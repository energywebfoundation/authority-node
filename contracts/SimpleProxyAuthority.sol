pragma solidity ^0.4.8;
import "./Owned.sol";

contract ValidatorSet {
    event InitiateChange(bytes32 indexed _parent_hash, address[] _new_set);

    function getValidators() constant returns (address[] _validators);
    function finalizeChange();
}

contract Proxy is Owned {

    // EVENTS

    event LogNewDB(address db);
    event LogNewAuthorityContract(address authorityContract);

    // STATE

    // Database for Validator contract
    AuthorityDB public db;
    address[] public previousDbs;

    // Logic for Validator contract
    address public authorityContract;
    address[] public previousContracts;

    function() {
        require(authorityContract.delegatecall(msg.data));
    }

    // SETTER

    function setAuthorityContract(address _authorityContract) onlyOwner {
        require(authorityContract != _authorityContract);
        previousContracts.push(authorityContract);
        authorityContract = _authorityContract;
        db.changeOwner(_authorityContract);
        LogNewAuthorityContract(_authorityContract);
    }

    function setDb(AuthorityDB _db) onlyOwner {
        require(db != _db);
        require(_db.owner() == address(this));
        previousDbs.push(db);
        db = _db;
        LogNewDB(_db);
    }

    function setAuthorityContractAndDb(address _authorityContract, AuthorityDB _db) onlyOwner {
        setAuthorityContract(_authorityContract);
        setDb(_db);
    }

    // GETTER
    function getValidators() constant returns (address[] _validators) {
        address[] memory tmp = new address[](db.getValidatorsListLength());
        for (uint i = 0; i < tmp.length; i++) {
            tmp[i] = db.validatorsList(i);
        }
        return tmp;
    }
}

contract AuthorityDB is Owned {
    address[] public validatorsList;
    address[] public pendingList;
    mapping(address => uint) public index;

    function AuthorityDB(address _owner) {
        owner = _owner; // has to be Proxy contract
    }

    // SETTER

    function setValidatorsList(address[] _validatorsList) onlyOwner {
        validatorsList = _validatorsList;
    }

    function setValidator(uint _index, address _validator) onlyOwner {
        validatorsList[_index] = _validator;
    }

    function setValidatorsListLength(uint _length) onlyOwner {
        validatorsList.length = _length;
    }

    function setIndex(address _address, uint _index) onlyOwner {
        index[_address] = _index;
    }

    function setPendingList(address[] _validatorList) onlyOwner {
        pendingList = _validatorList;
    }

    function setPending(uint _index, address _validator) onlyOwner {
        validatorsList[_index] = _validator;
    }

    function setPendingLength(uint _length) onlyOwner {
        pendingList.length = _length;
    }

    function finalize() {
        validatorsList = pendingList;
    }

    // GETTER

    function getValidators() constant returns (address[] _validators) {
        return validatorsList;
    }

    function getValidatorsListLength() constant returns(uint length) {
        return validatorsList.length;
    }
}

contract Authority is Owned, ValidatorSet {

    AuthorityDB db; // this is not used directly, since this contract is called through delegatecall. But this storage is at the same position than in the proxy contract

    function setAuthorities(address[] _validators) onlyOwner {
        db.setValidatorsList(_validators);
        for (uint i = 0; i < _validators.length; i++) {
            db.setIndex(_validators[i], i);
        }
    }

    function addValidator(address _validator) onlyOwner {
        address[] memory tmp = new address[](db.getValidatorsListLength() + 1);
        for (uint i = 0; i < tmp.length; i++) {
            tmp[i] = db.validatorsList(i);
        }
        tmp[tmp.length - 1] = _validator;
        db.setPendingList(tmp);
        InitiateChange(block.blockhash(block.number - 1), tmp);
    }

    function removeValidator(address _validator) onlyOwner {
        address[] memory tmp = new address[](db.getValidatorsListLength() - 1);
        for (uint i = 0; i < tmp.length - 1; i++) {
            tmp[i] = db.validatorsList(i);
        }
        address lastValidator = db.validatorsList(db.getValidatorsListLength() - 1);
        tmp[db.index(_validator)] = lastValidator;
        db.setPendingList(tmp);
        InitiateChange(block.blockhash(block.number - 1), tmp);
    }

    function getValidators() constant returns (address[] _validators) {
        address[] memory tmp = new address[](db.getValidatorsListLength());
        for (uint i = 0; i < tmp.length; i++) {
            tmp[i] = db.validatorsList(i);
        }
        return tmp;
    }

    function finalizeChange() {
        require(msg.sender == 0xfffffffffffffffffffffffffffffffffffffffe);
        db.finalize();
    }
}