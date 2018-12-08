declare -a arr=("google.com" "cisco.com" "reddit.com" "twitter.com" "github.com" "facebook.com" "bing.com" "youtube.com" "vmware.com" "wireshark.com" "firefox.com")

while (true); do
	for i in "${arr[@]}"; do
		wget "$i"
		sleep 2s

	done

done