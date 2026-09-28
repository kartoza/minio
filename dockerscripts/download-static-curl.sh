#!/bin/bash

# Pinned: releases after v8.11.0 no longer publish a curl-aarch64 asset.
STATIC_CURL_VERSION="${STATIC_CURL_VERSION:-v8.11.0}"

function download_arch_specific_executable {
	curl -f -L -s -q \
		"https://github.com/moparisthebest/static-curl/releases/download/${STATIC_CURL_VERSION}/curl-$1" \
		-o /go/bin/curl || exit 1
	chmod +x /go/bin/curl
}

case $TARGETARCH in
"arm64")
	download_arch_specific_executable aarch64
	;;
"s390x")
	echo "Not downloading static cURL because it does not exist for the $TARGETARCH architecture."
	;;
*)
	download_arch_specific_executable "$TARGETARCH"
	;;
esac
