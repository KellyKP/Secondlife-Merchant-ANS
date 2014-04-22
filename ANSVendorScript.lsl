string product;
string ProductID = "12345";
integer price;
integer TransID = 2345;
string url = "http://example.com/ans.php"; // URL of your ANS script
key reqid; //ANS request ID

//If you want split profit, change share to TRUE then add key to ShareWith
integer share = FALSE;// TRUE or FALSE
key ShareWith = "59cfdfae-167b-4a3d-85a9-0e824df1872d";// Key of friend
integer cut = 5; // Percentage cut

//Save system
SaveToANS(string TransactionID, string ItemID, string ItemName, string PayerName, key PayerKey, string ReceiverName, key ReceiverKey, string MerchantName, integer PaymentGross, string Location)
{
    string values =     "TransactionID="+TransactionID+
                        "&ItemID="+ItemID+
                        "&ItemName="+ItemName+
                        "&PayerName="+PayerName+
                        "&PayerKey="+(string)PayerKey+
                        "&ReceiverName="+ReceiverName+
                        "&ReceiverKey="+(string)ReceiverKey+
                        "&MerchantName="+MerchantName+
                        "&Location="+Location+
                        "&PaymentGross="+(string)PaymentGross;
                        
                
    reqid = llHTTPRequest(url+"?"+values,[HTTP_METHOD,"POST",HTTP_MIMETYPE,"application/x-www-form-urlencoded"], "");
}

default
{
    state_entry()
    {
        price = (integer)llGetObjectDesc();
        product = llGetObjectName();
        llSetPayPrice(PAY_HIDE,[price,PAY_HIDE,PAY_HIDE,PAY_HIDE]);
        if (share == TRUE)
        llRequestPermissions(llGetOwner(),PERMISSION_DEBIT);
    }

    http_response(key request_id, integer status, list metadata, string body)
    {
        if (request_id == reqid)
        {
            // status 200 = success, so this will check if status is not 200, then say error, else say success message
        if(status != 200)
            llOwnerSay("you've had a new sale,but you ANS server didn't respond correctly, and has returned the following:\nStatus: "+(string)status+"\nBody: "+body);
        else
            llOwnerSay("you've sold "+product+" for "+(string)price+"L$,it was successfully added to ANS records.");
        }
    }
    
    money(key id,integer amnt)
    {
        
    //

                string InvenName;
                integer InvenNumber = llGetInventoryNumber(INVENTORY_ALL);
                list InvenList = [];
                integer y;
                for(y = 0; y < InvenNumber; y++)
                {
                    InvenName = llGetInventoryName(INVENTORY_ALL, y);
                    if(InvenName != llGetScriptName()) InvenList += [InvenName];
                }
                llGiveInventoryList(id,product, InvenList);
                if (share == TRUE)
                llGiveMoney(ShareWith,(amnt*cut)/100);

    //
        llInstantMessage(id,"Thank you "+llKey2Name(id)+" for your purchase, look for a folder named \""+product+"\" in your recent items.");

        //Collects info for transaction, and prepares for saving.
        TransID = TransID += 1;
        string lTransactionID = (string)TransID;
        string lItemID = ProductID;
        string lItemName = product;
        string lPayerName = llEscapeURL(llKey2Name(id));
        key lPayerKey = id;
        string lReceiverName = llEscapeURL(llKey2Name(id));
        key lReceiverKey = id;
        string lMerchantName = llEscapeURL(llKey2Name(llGetOwner()));
        integer lPaymentGross = price;
        string lLocation = "In-World";

        // saves collected info.
        SaveToANS(lTransactionID,lItemID,lItemName,lPayerName,lPayerKey,
        lReceiverName,lReceiverKey,lMerchantName,lPaymentGross,lLocation);
    }  
}