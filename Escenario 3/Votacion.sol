// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <=0.9.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "./Base64.sol";
import "./TokenVotante.sol";


contract Votacion is ERC721, ERC721Enumerable, TokenVotante{
    using Counters for Counters.Counter; //librearia contador
    using Strings for uint256;

    Counters.Counter private _idCounter; //contador de los tokens
    uint256 public maxSupply; //cantidad máxima de tokens
    mapping(uint256 => uint256) public votantesTokens; //Tokens de los votantes

    constructor(uint256 _maxSupply) ERC721("TokenVoto", "TKV") {
        maxSupply = _maxSupply; //asignamos la cantidad máxima de tokens
    } 
    function getMaxSupply() public view returns(uint256){
        return maxSupply;
    }
    function mint(uint256 _ci) public {
        uint256 current = _idCounter.current();
        require(current < maxSupply, "Limite de tokens alcanzado");
        votantesTokens[current] = cifradoVotante(current, msg.sender, _ci);
        _safeMint(msg.sender, current);
        _idCounter.increment();
    }
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}