/*
/*
Attention, important warning here!
This is a poc version, it should not be used on real network
Working on proof of location project with OpenSpace Team at ActInSpace, the international Hackathon application co-organized by CNES and ESA 👨‍🚀👽🛰
CNES has developed a system (EP3276561) that is easy to use, capable of generating a robust serial number, time-stamped and geolocated from GNSS data received at a time t: 
the GNSS data issued by geolocation satellites contain tamper-proof information that can be used to estimate the location of a receiver, as well as the moment when these data were received. 
From these data, the system is able to extract the appropriate information and to generate a robust and unique serial number, which includes precise information about the place and time this serial number was generated. 
The tag generating system is an integral part of the system for printing serial numbers, and must be located close to the products whose origin the user wishes to prove.
*/
pragma solidity ^ 0.4 .0;
contract Proofer {

    // bank adress
    address public bankAddress = 0xe2f9D68BB0D2aDcB0d926E93896366D0f2a45738;
     
    struct Area {
        uint256 lat;
        uint256 lng;
        uint256 radius;
    }
    
    mapping(address => uint256[]) public areasBySender;
    
    Area[] public areas;
    
     struct Transaction {
        uint256 blockNumber;
    }
    
    Transaction[] public transactions;
    
    //mapping(address => uint256[]) public transactionsBySender;
    
    // maps the transaction ID to a bool (has the 
    mapping(uint256 => bool) public validatedTransaction;
    
    function newArea(uint256 _lat, uint256 _lng, uint256 _radius) public returns (uint256 areaID) {
        // increase area array length by 1
        areaID = areas.length++;

        // store area data in the areas array
        areas[areaID] = Area({
            lat: _lat,
            lng: _lng,
            radius: _radius
        });
        // add the area ID to that senders address
        areasBySender[msg.sender].push(areaID);
        
        // todo fire newArea event
        //LogNewArea(msg.sender);
    }
    
    // only bank can use the method with this modifier
    modifier onlyBank() {
        require(msg.sender == bankAddress);
        _;
    }
    
    function newPendindTransaction(uint256 _amount) public onlyBank() returns (uint256 transactionID)  {
        // increase transaction array length by 1
        transactionID = transactions.length++;

        // store area data in the areas array
        transactions[transactionID] = Transaction({
            blockNumber:block.number
        });
        
        //todo: fire newArea event
        //LogNewTransaction(msg.sender);
    }
    
    //ProoferID is generated by IoT
    //system for generating tamper-proof, timestamped and geolocated serial numbers
    
    function validTransactionByProoferID(uint256 _transactionID, uint256 _prooferID) public onlyBank() returns (bool result)  {

        //todo: extract lat lng (and temper proof vor v2) from _prooferID
        //todo: get area of sender
        //todo: compare if _prooferID is inside authorized areas
        //todo: fire validatedTransaction event
        validatedTransaction[_transactionID] = true;

    }

}