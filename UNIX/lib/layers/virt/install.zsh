if urf_contains $WHARDWARE virt; then
    PKGS=$PKGS" build-essential dkms linux-headers-$(uname -r)"
fi
