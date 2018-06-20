# hashtag

## tagline
The global game of virtual tag.

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
	* suggest that taggers manually notify the taggee (but then restricts taggees to people you know)
* potentially incentivize taggers to motivate their taggees to continue the tag chain by having them stake some ETH that they only get back if their taggee tags somebody else within a given period (but then increases the barrier to tagging somebody in the first place)
* "it" is represented by an NFT, whose contract only mints the 1 token at initialization
* once you tag somebody else, a "souvenir" NFT is minted and sent to you commemorating which "it" you were--e.g. the 43rd "it"
