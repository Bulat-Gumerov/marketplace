module github.com/dgamingfoundation/marketplace

go 1.12

require (
	github.com/cosmos/cosmos-sdk v0.28.2-0.20190811175253-caec9f3c55b0
	github.com/dgamingfoundation/cosmos-sdk v0.0.0-20190815130634-d34060ae8455 // indirect
	github.com/go-logfmt/logfmt v0.4.0 // indirect
	github.com/google/uuid v1.1.1
	github.com/gorilla/mux v1.7.0
	github.com/magiconair/properties v1.8.0
	github.com/mattn/go-isatty v0.0.7 // indirect
	github.com/prometheus/client_golang v1.0.0
	github.com/prometheus/common v0.4.1
	github.com/spf13/afero v1.2.2 // indirect
	github.com/spf13/cobra v0.0.5
	github.com/spf13/viper v1.3.2
	github.com/stretchr/testify v1.3.0
	github.com/tendermint/go-amino v0.15.0
	github.com/tendermint/tendermint v0.32.2
	github.com/tendermint/tm-db v0.1.1
	golang.org/x/sys v0.0.0-20190329044733-9eb1bfa1ce65 // indirect
	google.golang.org/appengine v1.4.0 // indirect
	google.golang.org/genproto v0.0.0-20190327125643-d831d65fe17d // indirect
)

replace github.com/cosmos/cosmos-sdk => github.com/dgamingfoundation/cosmos-sdk v0.0.0-20190806155809-7f4388fe7599
