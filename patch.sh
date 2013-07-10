#!/bin/sh
#
# Copyright (c) 2009-2013 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Split out, so build_kernel.sh and build_deb.sh can share..

git="git am"

if [ -f ${DIR}/system.sh ] ; then
	. ${DIR}/system.sh
fi

if [ "${RUN_BISECT}" ] ; then
	git="git apply"
fi

echo "Starting patch.sh"

git_add () {
	git add .
	git commit -a -m 'testing patchset'
}

start_cleanup () {
	git="git am --whitespace=fix"
}

cleanup () {
	git format-patch -${number} -o ${DIR}/patches/
	exit
}

arm () {
	echo "dir: arm"
	${git} "${DIR}/patches/arm/0001-deb-pkg-Simplify-architecture-matching-for-cross-bui.patch"
}

omap () {
	echo "dir: omap"
	#Fixes 800Mhz boot lockup: http://www.spinics.net/lists/linux-omap/msg83737.html
#	${git} "${DIR}/patches/omap/0001-regulator-core-if-voltage-scaling-fails-restore-orig.patch"
	${git} "${DIR}/patches/omap/0002-omap2-twl-common-Add-default-power-configuration.patch"

	echo "dir: omap/sakoman"
	${git} "${DIR}/patches/omap_sakoman/0001-OMAP-DSS2-add-bootarg-for-selecting-svideo.patch"
	${git} "${DIR}/patches/omap_sakoman/0002-video-add-timings-for-hd720.patch"

	echo "dir: omap/beagle/expansion"
	${git} "${DIR}/patches/omap_beagle_expansion/0001-Beagle-expansion-add-buddy-param-for-expansionboard-.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0002-Beagle-expansion-add-zippy.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0003-Beagle-expansion-add-zippy2.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0004-Beagle-expansion-add-trainer.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0005-Beagle-expansion-add-CircuitCo-ulcd-Support.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0006-Beagle-expansion-add-wifi.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0007-Beagle-expansion-add-beaglefpga.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0008-Beagle-expansion-add-spidev.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0009-Beagle-expansion-add-Aptina-li5m03-camera.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0010-Beagle-expansion-add-LSR-COM6L-Adapter-Board.patch"
	${git} "${DIR}/patches/omap_beagle_expansion/0011-Beagle-expansion-LSR-COM6L-Adapter-Board-also-initia.patch"

	echo "dir: omap/beagle"
	#Status: for meego guys..
	${git} "${DIR}/patches/omap_beagle/0001-meego-modedb-add-Toshiba-LTA070B220F-800x480-support.patch"
	${git} "${DIR}/patches/omap_beagle/0002-backlight-Add-TLC59108-backlight-control-driver.patch"
	${git} "${DIR}/patches/omap_beagle/0003-tlc59108-adjust-for-beagleboard-uLCD7.patch"

	#Status: not for upstream
	${git} "${DIR}/patches/omap_beagle/0004-zeroMAP-Open-your-eyes.patch"

	${git} "${DIR}/patches/omap_beagle/0005-ARM-OMAP-Beagle-use-TWL4030-generic-reset-script.patch"
	${git} "${DIR}/patches/omap_beagle/0006-DSS2-use-DSI-PLL-for-DPI-with-OMAP3.patch"

	echo "dir: omap/panda"
	#Status: not for upstream: push device tree version upstream...
	${git} "${DIR}/patches/omap_panda/0001-panda-fix-wl12xx-regulator.patch"
	#Status: unknown: cherry picked from linaro
	${git} "${DIR}/patches/omap_panda/0002-ti-st-st-kim-fixing-firmware-path.patch"
	${git} "${DIR}/patches/omap_panda/0003-Panda-expansion-add-spidev.patch"
	${git} "${DIR}/patches/omap_panda/0004-HACK-PandaES-disable-cpufreq-so-board-will-boot.patch"
#	${git} "${DIR}/patches/omap_panda/0005-HACK-panda-enable-OMAP4_ERRATA_I688.patch"
	${git} "${DIR}/patches/omap_panda/0006-ARM-hw_breakpoint-Enable-debug-powerdown-only-if-sys.patch"

	#Fix wlan0 on original Panda (strangly the ES was fine...)
	#v3.10.x
	#git revert --no-edit d1924519fe1dada0cfd9a228bf2ff1ea15840c84 -s
	${git} "${DIR}/patches/omap_panda/0007-Revert-regulator-twl-Remove-TWL6030_FIXED_RESOURCE.patch"
	#v3.7.x
	#git revert --no-edit 029dd3cefa46ecdd879f9b4e2df3bdf4371cc22c -s
	${git} "${DIR}/patches/omap_panda/0008-Revert-regulator-twl-Remove-another-unused-variable-.patch"
	#v3.6.x
	#git revert --no-edit e76ab829cc2d8b6350a3f01fffb208df4d7d8c1b -s
	#git revert --no-edit 0e8e5c34cf1a8beaaf0a6a05c053592693bf8cb4 -s
	${git} "${DIR}/patches/omap_panda/0009-Revert-regulator-twl-Remove-references-to-the-twl403.patch"
	${git} "${DIR}/patches/omap_panda/0010-Revert-regulator-twl-Remove-references-to-32kHz-cloc.patch"

	#spidev: make sure to set the pins up...
	${git} "${DIR}/patches/omap_panda/0011-panda-spidev-setup-pinmux.patch"

	#Status: not for upstream: http://www.spinics.net/lists/arm-kernel/msg214633.html
	#Fixes:
	#WARNING: "v7_dma_flush_range" *pvrsrvkm.ko] undefined!
	#WARNING: "v7_dma_map_area" *pvrsrvkm.ko] undefined!
	${git} "${DIR}/patches/omap_sgx/0001-arm-Export-cache-flush-management-symbols-when-MULTI.patch"
}

saucy () {
	echo "dir: saucy"
	${git} "${DIR}/patches/saucy/0001-saucy-disable-stack-protector.patch"
}

sprz319_erratum () {
	echo "dir: omap_sprz319-erratum-2.1"
	${git} "${DIR}/patches/omap_sprz319-erratum-2.1/0001-hack-omap-clockk-dpll5-apply-sprz319e-2.1-erratum.patch"
}

imx () {
	echo "dir: imx"
	${git} "${DIR}/patches/imx/0001-ARM-imx-Enable-UART1-for-Sabrelite.patch"
	${git} "${DIR}/patches/imx/0002-Add-IMX6Q-AHCI-support.patch"
	${git} "${DIR}/patches/imx/0003-imx-Add-IMX53-AHCI-support.patch"
	${git} "${DIR}/patches/imx/0004-SAUCE-imx6-enable-sata-clk-if-SATA_AHCI_PLATFORM.patch"
	${git} "${DIR}/patches/imx/0005-thermal-add-imx-thermal-driver-support.patch"
	#http://marc.info/?l=linux-arm-kernel&m=137286613127404&w=2
	${git} "${DIR}/patches/imx/0006-ARM-mx6-Fix-the-number-of-reported-cores.patch"
	${git} "${DIR}/patches/imx/0007-i.MX6-Wandboard-add-CKO1-clock-output.patch"
	${git} "${DIR}/patches/imx/0008-i.MX6-Wandboard-add-wifi-bt-rfkill-driver.patch"
}

dts () {
	echo "dir: dts"
	${git} "${DIR}/patches/dts/0001-wandboard-add-quad-plus-2nd-mmc-card.patch"
#wip:
#	${git} "${DIR}/patches/dts/0002-i.MX6-Wandboard-add-sound-stgl5000-and-wifi-bt.patch"
}

arm
omap
saucy

#Disabled for testing...
#sprz319_erratum

imx
dts

echo "patch.sh ran successful"
