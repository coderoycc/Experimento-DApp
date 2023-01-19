// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenVotante{
    uint256[] private _ciVotantes = [
        487621,
        876572,
        651234,
        133125,
        796567,
        705378,
        772134,
        285423,
        652472
    ];

    function cifradoVotante(uint256 _tokenID, address _votante, uint256 _ci) 
        public 
        pure 
        returns(uint256){
        uint256 combinedParams = _tokenID + uint160(_votante) + _ci;
        bytes memory encodedParams = abi.encodePacked(combinedParams);
        bytes32 hashedParams = keccak256(encodedParams);
        return uint256(hashedParams);
    }

    
}