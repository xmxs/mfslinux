arch="x86_64";
ver=$(awk '/^OPENWRT_VERSION/{print $NF}' Makefile);
r=$(awk -F '[/_]+' '{print $2}' config/default/openwrt_packages_add|sed -r 's/^/\^/g'|sed -r 's/$/_[0-9]/g'|tr '\n' '|'|sed -r 's/\|$//g');
>config/default/openwrt_packages_add;
curl "https://downloads.openwrt.org/releases/${ver}/packages/${arch}/package/Packages.manifest" -Ssm5 | awk '/^Filename:/{print $NF}' | grep -Ei "${r}" | sed -r 's~^~package/~g' >> config/default/openwrt_packages_add;
curl "https://downloads.openwrt.org/releases/${ver}/packages/${arch}/base/Packages.manifest" -Ssm5 | awk '/^Filename:/{print $NF}' | grep -Ei "${r}" | sed -r 's~^~base/~g' >> config/default/openwrt_packages_add;
