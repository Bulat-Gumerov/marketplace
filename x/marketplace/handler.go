package marketplace

import (
	"fmt"

	sdk "github.com/cosmos/cosmos-sdk/types"
	xnft "github.com/cosmos/cosmos-sdk/x/nft"
	"github.com/google/uuid"
)

// NewHandler returns a handler for "marketplace" type messages.
func NewHandler(keeper Keeper) sdk.Handler {
	return func(ctx sdk.Context, msg sdk.Msg) sdk.Result {
		switch msg := msg.(type) {
		case MsgMintNFT:
			return handleMsgMintNFT(ctx, keeper, msg)
		case MsgTransferNFT:
			return handleMsgTransferNFT(ctx, keeper, msg)
		case MsgSellNFT:
			return handleMsgSellNFT(ctx, keeper, msg)
		default:
			errMsg := fmt.Sprintf("Unrecognized marketplace Msg type: %v", msg.Type())
			return sdk.ErrUnknownRequest(errMsg).Result()
		}
	}
}

func handleMsgMintNFT(ctx sdk.Context, keeper Keeper, msg MsgMintNFT) sdk.Result {
	nft := NewNFT(
		xnft.NewBaseNFT(
			uuid.New().String(),
			msg.Owner,
			msg.Name,
			msg.Description,
			msg.Image,
			msg.TokenURI,
		),
		sdk.NewCoin("token", sdk.NewInt(0)),
	)
	if err := keeper.MintNFT(ctx, nft); err != nil {
		return sdk.Result{
			Code:      sdk.CodeUnknownRequest,
			Codespace: "marketplace",
			Data:      []byte(fmt.Sprintf("failed to MintNFT: %v", err)),
		}
	}

	return sdk.Result{}
}

func handleMsgTransferNFT(ctx sdk.Context, keeper Keeper, msg MsgTransferNFT) sdk.Result {
	if err := keeper.TransferNFT(ctx, msg.TokenID, msg.Sender, msg.Recipient); err != nil {
		return sdk.Result{
			Code:      sdk.CodeUnknownRequest,
			Codespace: "marketplace",
			Data:      []byte(fmt.Sprintf("failed to TransferNFT: %v", err)),
		}
	}
	return sdk.Result{}
}

func handleMsgSellNFT(ctx sdk.Context, keeper Keeper, msg MsgSellNFT) sdk.Result {
	if err := keeper.SellNFT(ctx, msg.TokenID, msg.Owner, msg.Price); err != nil {
		return sdk.Result{
			Code:      sdk.CodeUnknownRequest,
			Codespace: "marketplace",
			Data:      []byte(fmt.Sprintf("failed to TransferNFT: %v", err)),
		}
	}
	return sdk.Result{}
}
