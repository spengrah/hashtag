# hashtag
**tagline**: The global game of virtual tag.

## concept
Tag, you're it! You played this game with your friends or with your siblings when you were young. The goal of this project is to let you play with the entire Ethereum network.

## basic parameters
1. At any given moment there is only one "it"
2. "It" status is provable and does not change unless the current "it" tags somebody (or something; see below)

## game mechanics and implementation
**considerations**
* need a way for the taggee to be notified that they were tagged and are now "it"
* need a mechanism to prevent the game from getting stuck
* if it somehow does get stuck--say if somebody gets tagged and doesn't realize it--need a mechanism to reset it. Perhaps after a set period of time, e.g. 1 week

**ideas**
* in addition to externally owned addresses, ideally would be able to tag a non-fungible token (e.g. a cryptokitty) that is owned by an externally owned address
* possibilities for a tag notification:
	* tie to known identity, e.g. uport, status, peepeth account, etc.
	* rely on mobile wallet transaction push notifications (but how do you know the taggee has such a wallet?)
	* suggest that taggers manually notify the tagee (but then restricts tagees to people you know)
* potentially incentivize taggers to motivate their tagees to continue the tag chain by having them stake some ETH that they only get back if their tagee tags somebody else within a given period (but then increases the barrier to tagging somebody in the first place)
* "it" is represented by an NFT, whose contract only mints the 1 token at initialization
	* this NFT should conform to the ERC721 standard, but can only be transferred when a tagging function is called on the tag contract
* once you tag somebody else, a "souvenir" NFT is minted and sent to you commemorating which "it" you were in series--for example, if you were tagged by the 42nd "it" and then tag somebody else, you'd receive an NFT with a property designating you as the 43rd "it".
	* this NFT should be non-transferable (would this break conformity with the ERC721 standard?)
	
## back end
Three smart contracts:
1. hashtag contract - controls the game mechanics; implements incentive mechanisms; triggers minting and transfering of current_it and previous_it NFTs

	https://ethereum.stackexchange.com/questions/42/how-can-a-contract-run-itself-at-a-later-time

2. current_it ERC721 contract - only ever mints one NFT, on instantiation; transfers that NFT from the tagger_address to the tagee_address
	* should we combine #1 and #2?

3. previous_it ERC721 contract - when the current_it NFT is transfered to the tagee_address, this contract mints a new previous_it NFT and transfers it to the tagger_address

## front end
**input**: tagee_address (eventually expand to composable NFT pointer)

**action**: "tag" the tagee - calls the hashtag.tag function

**content**: display incentive information (e.g. countdown until your tagee must tag somebody else for you to get your ETH back)
