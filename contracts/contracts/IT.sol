/* SPDX-License-Identifier: MIT */
pragma solidity 0.8.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "IHashTAGManager.sol";


contract IT is ERC721("HashTAG IT Token", "IT") {
    IHashTAGManager public manager;
    IERC20 private _depositToken;
    IERC20 public TAG;

    address public previousIt; // the account who tagged the current It
    uint256 public previousTag; // the timestamp of when previousIt tagged the current It

    bytes32 public previousIts; // hash of all historical Its

    event Reward(address recipient, uint256 amount);

    constructor(address _manager, address _tagToken, address _initialIt, uint256 _cliff) {
        manager = IHashTAGManager(_manager);
        cliff = _cliff;
        _safeMint(_initialIt, 0);
        _depositToken = IERC20(manager.depositToken());
        TAG = IERC20(_tagToken);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        // ideally do something with the 
        return "";
    }

    /**
     * @dev Hook that is called before any token transfer. This includes minting
     * and burning.
     *
     * Calling conditions:
     *
     * - When `from` and `to` are both non-zero, ``from``'s `tokenId` will be
     * transferred to `to`.
     * - When `from` is zero, `tokenId` will be minted for `to`.
     * - When `to` is zero, ``from``'s `tokenId` will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override {
        if(previousIt != address(0)) {
            _sendReward();
            _hashIts();
            _mintHistoricalIT();
        }

        previousIt = from;
        previousTag = block.timestamp;
    }

    // TODO should this be inside the manager instead?
    function _sendReward() internal {
        uint256 elapsed = block.timestamp - previousTag;
        uint256 cliff = manager.cliff();
        uint256 multiplier = 
            (elapsed < cliff) ? 
            (cliff / ratio) : 
            1;
        uint256 baseReward = manager.baseReward();
        uint256 reward = baseReward * multiplier;

        uint256 remainingTAG = TAG.balanceOf(address(this)); 

        uint256 actualReward = 
            (remainingTAG <= reward) ?
            reward : 
            remainingTAG;

        require(TAG.transfer(previousIt, actualReward), "transfer failed");

        emit Reward(previousIt, actualReward);
    }

    // TODO should this be inside the manager instead?
    function _mintHistoricalIT() internal {
        // mint an new HistoricalIT nft
        HistoricalIT.mint(previousIt); // pseudo code
    }

    function _hashIts() internal {
        // hash historical It addresses
    }


}