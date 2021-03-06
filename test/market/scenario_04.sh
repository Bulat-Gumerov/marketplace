#!/usr/bin/env bash

sleep_time=5

echo "run test 04:"
echo "Create an NFT. Put this NFT on market with correct token ID, price and seller beneficiary address."
echo "Expected: the NFT is updated with price and seller beneficiary address, its Status field equals 'on_market'."

uu=$(uuidgen)
user1_id=$(mpcli keys show user1 -a)
mpcli tx nft mint name $uu $user1_id --from user1 -y <<< '12345678' >/dev/null

sleep $sleep_time

nft_id=$(mpcli query marketplace nft $uu | grep -oP '(?<=\"id\": \")(.*)(?=\".*)' -m 1)

if [[ $uu != $nft_id ]]
then
      echo "Error: token not created"
      exit 1
else
      echo "token created: $nft_id"
fi

seller_id=$(mpcli keys show sellerBeneficiary -a)

mpcli tx marketplace put_on_market $nft_id 150token $seller_id --from user1 -y <<< '12345678' >/dev/null

sleep $sleep_time

nft_sel_ben_id=$(mpcli query marketplace nft $nft_id | grep -oP '(?<=\"seller_beneficiary\": \")(.*)(?=\".*)' -m 1)
status=$(mpcli query marketplace nft $nft_id | grep -oP '(?<=\"status\": \")(.*)(?=\".*)' -m 1 | tr -d ,)
price=$(mpcli query marketplace nft $nft_id | grep -oP '(?<=\"price\": ).*' -m 1)

echo $nft_sel_ben_id
echo $seller_id
echo $status
echo $price

if [[ $seller_id == $nft_sel_ben_id ]] && [[ $status == "on_market" ]] && [[ $price != "[]," ]]
then
      echo "test SUCCESS, nft was put on market: $seller_id"
else
      echo "test FAILURE"
      exit 1
fi