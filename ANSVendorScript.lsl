string product;
string ProductID = "12345";
integer price;
integer TransID = 2345;
string url = "http://example.com/ans.php"; // URL of your ANS script
key reqid; //ANS request ID

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
        product = llGetInventoryName(INVENTORY_OBJECT, 0);
        llSetPayPrice(PAY_HIDE,[price,PAY_HIDE,PAY_HIDE,PAY_HIDE]);
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
        llGiveInventory(id,product);
        llInstantMessage(id,"Thank you "+llKey2Name(id)+" for your purchase, look for an Object named \""+product+"\" in your inventory Objects folder");

        //Collects info for transaction, and prepares for saving.
        TransID = TransID += 1;
        string lTransactionID = (string)TransID;
        string lItemID = ProductID;
        string lItemName = product;
        string lPayerName = llKey2Name(id);
        key lPayerKey = id;
        string lReceiverName = llKey2Name(id);
        key lReceiverKey = id;
        string lMerchantName = llKey2Name(llGetOwner());
        integer lPaymentGross = price;
        string lLocation = "In-World";

        // saves collected info.
        SaveToANS(lTransactionID,lItemID,lItemName,lPayerName,lPayerKey,
        lReceiverName,lReceiverKey,lMerchantName,lPaymentGross,lLocation);
    }  
}