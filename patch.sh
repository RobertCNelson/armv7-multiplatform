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
	if [ "${number}" ] ; then
		git format-patch -${number} -o ${DIR}/patches/
	fi
	exit
}

arm () {
	echo "dir: arm"
	${git} "${DIR}/patches/arm/0001-deb-pkg-Simplify-architecture-matching-for-cross-bui.patch"
}

drivers () {
	echo "dir: drivers"
	${git} "${DIR}/patches/drivers/0001-thermal-add-imx-thermal-driver-support.patch"
	${git} "${DIR}/patches/drivers/0002-ASoC-sglt5000-Provide-the-reg_stride-field.patch"
	${git} "${DIR}/patches/drivers/0003-ASoC-imx-sgtl5000-fix-error-return-code-in-imx_sgtl5.patch"
	${git} "${DIR}/patches/drivers/0004-ASoC-sgtl5000-defer-the-probe-if-clock-is-not-found.patch"
}

imx_dts () {
	echo "dir: imx_dts"
	#With all the imx6*.dtsi changes, its eaiser to just pull the for-next then try to manually rebase
	#https://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=shortlog;h=refs/heads/for-next

	${git} "${DIR}/patches/imx_dts/0001-ARM-i.MX53-Fix-UART-pad-configuration.patch"
	${git} "${DIR}/patches/imx_dts/0002-ARM-imx27-Fix-documentation-for-SPLL-clock.patch"
	${git} "${DIR}/patches/imx_dts/0003-ARM-i.MX27-Typo-fix.patch"
	${git} "${DIR}/patches/imx_dts/0004-ARM-i.MX6Q-Fix-IOMUXC-GPR1-defines-for-ENET_CLK_SEL-.patch"
	${git} "${DIR}/patches/imx_dts/0005-ARM-i.MX6Q-correct-emi_sel-clock-muxing.patch"
	${git} "${DIR}/patches/imx_dts/0006-ARM-mxs-saif0-is-the-clock-provider-to-sgtl5000.patch"
	${git} "${DIR}/patches/imx_dts/0007-ARM-imx-fix-vf610-enet-module-clock-selection.patch"
	${git} "${DIR}/patches/imx_dts/0008-ARM-i.MX53-mba53-Fix-PWM-backlight-DT-node.patch"
	${git} "${DIR}/patches/imx_dts/0009-ARM-dts-imx6dl-add-a-new-pinctrl-for-ecspi1.patch"
	${git} "${DIR}/patches/imx_dts/0010-ARM-dts-imx6q-add-a-new-pinctrl-for-ecspi1.patch"
	${git} "${DIR}/patches/imx_dts/0011-ARM-dts-imx6qdl-sabresd-enable-the-SPI-NOR.patch"
	${git} "${DIR}/patches/imx_dts/0012-apf27dev-add-rtc-ds1374-to-the-device-tree.patch"
	${git} "${DIR}/patches/imx_dts/0013-ARM-dts-imx27-Add-SAHARA2-devicetree-node.patch"
	${git} "${DIR}/patches/imx_dts/0014-ARM-dts-imx27-Add-AUDMUX-devicetree-node.patch"
	${git} "${DIR}/patches/imx_dts/0015-ARM-dts-imx27-Rename-PWM-devicetree-node.patch"
	${git} "${DIR}/patches/imx_dts/0016-ARM-dts-imx27-Sort-entries-by-address.patch"
	${git} "${DIR}/patches/imx_dts/0017-ARM-dts-imx27-phytec-phycore-som-Define-minimal-memo.patch"
	${git} "${DIR}/patches/imx_dts/0018-ARM-dts-imx27-Add-kpp-devicetree-node.patch"
	${git} "${DIR}/patches/imx_dts/0019-ARM-dts-i.MX6-sync-imx6q-and-imx6dl-pinmux-entries.patch"
	${git} "${DIR}/patches/imx_dts/0020-ARM-dts-i.MX6qdl-Add-compatible-and-clock-to-flexcan.patch"
	${git} "${DIR}/patches/imx_dts/0021-ARM-dts-i.MX6qdl-Add-i.MX31-compatible-to-gpt-node.patch"
	${git} "${DIR}/patches/imx_dts/0022-ARM-dts-i.MX27-Add-iim-node.patch"
	${git} "${DIR}/patches/imx_dts/0023-ARM-dts-i.MX31-Add-iim-node.patch"
	${git} "${DIR}/patches/imx_dts/0024-ARM-dts-i.MX25-Add-iim-node.patch"
	${git} "${DIR}/patches/imx_dts/0025-ARM-dts-i.MX51-Add-iim-node.patch"
	${git} "${DIR}/patches/imx_dts/0026-ARM-dts-i.MX53-Add-iim-node.patch"
	${git} "${DIR}/patches/imx_dts/0027-ARM-dts-i.MX25-Add-i2c-and-spi-aliases.patch"
	${git} "${DIR}/patches/imx_dts/0028-ARM-dts-i.MX27-Add-i2c-aliases.patch"
	${git} "${DIR}/patches/imx_dts/0029-ARM-dts-i.MX51-Add-i2c-and-spi-aliases.patch"
	${git} "${DIR}/patches/imx_dts/0030-ARM-dts-i.MX53-Add-i2c-and-spi-aliases.patch"
	${git} "${DIR}/patches/imx_dts/0031-ARM-dts-i.MX6-Add-i2c-and-spi-aliases.patch"
	${git} "${DIR}/patches/imx_dts/0032-ARM-dts-i.MX51-move-kpp-pinmux-entry.patch"
	${git} "${DIR}/patches/imx_dts/0033-ARM-dts-i.MX51-babbage-Add-spi-cs-high-property-to-p.patch"
	${git} "${DIR}/patches/imx_dts/0034-ARM-dts-i.MX51-Add-USB-host1-2-pinmux-entries.patch"
	${git} "${DIR}/patches/imx_dts/0035-ARM-imx27-Use-AITC-for-the-interrupt-controller-name.patch"
	${git} "${DIR}/patches/imx_dts/0036-ARM-dts-imx27-Add-imx-framebuffer-device.patch"
	${git} "${DIR}/patches/imx_dts/0037-ARM-dts-imx27-Add-1-wire.patch"
	${git} "${DIR}/patches/imx_dts/0038-ARM-dts-imx27-cpufreq-cpu0-frequencies.patch"
	${git} "${DIR}/patches/imx_dts/0039-ARM-dts-Add-device-tree-support-for-phycard-pca100.patch"
	${git} "${DIR}/patches/imx_dts/0040-ARM-dts-add-sram-for-imx53-and-imx6q.patch"
	${git} "${DIR}/patches/imx_dts/0041-ARM-dts-mx53qsb-Enable-VPU-support.patch"
	${git} "${DIR}/patches/imx_dts/0042-ARM-i.MX6DL-dts-add-clock-and-mux-configuration-for-.patch"
	${git} "${DIR}/patches/imx_dts/0043-ARM-dts-imx-add-dma-cells-property-for-sdma.patch"
	${git} "${DIR}/patches/imx_dts/0044-ARM-dts-i.MX27-Move-IIM-node-under-AIPI2-bus.patch"
	${git} "${DIR}/patches/imx_dts/0045-ARM-dts-i.MX27-Add-WEIM-node.patch"
	${git} "${DIR}/patches/imx_dts/0046-ARM-dts-imx27-phytec-phycore-som-Add-WEIM-node.patch"
	${git} "${DIR}/patches/imx_dts/0047-ARM-dts-imx27-phytec-phycore-som-Add-SRAM-node.patch"
	${git} "${DIR}/patches/imx_dts/0048-ARM-dts-imx27-phytec-phycore-rdk-Add-CAN-node.patch"
	${git} "${DIR}/patches/imx_dts/0049-ARM-dts-imx27-phytec-phycore-som-Using-labels-for-re.patch"
	${git} "${DIR}/patches/imx_dts/0050-ARM-dts-imx27-phyCARD-S-remove-wrong-I2C-RTC.patch"
	${git} "${DIR}/patches/imx_dts/0051-ARM-dts-imx6dl-wandboard-Add-audio-support.patch"
	${git} "${DIR}/patches/imx_dts/0052-ARM-dts-imx-Add-the-missing-cpus-node.patch"
	${git} "${DIR}/patches/imx_dts/0053-ARM-dts-imx27-phyCARD-S-SOM-remove-wrong-i2c-sensor.patch"
	${git} "${DIR}/patches/imx_dts/0054-ARM-dts-imx27-phyCARD-S-move-i2c1-and-owire-to-rdk.patch"
	${git} "${DIR}/patches/imx_dts/0055-ARM-dts-imx27-phyCARD-S-i2c-ADC-device-node.patch"
	${git} "${DIR}/patches/imx_dts/0056-ARM-dts-imx6sl-add-fsl-imx6q-uart-for-uart-compatibl.patch"
	${git} "${DIR}/patches/imx_dts/0057-ARM-dts-imx6q-dl-add-DTE-pads-for-uart.patch"
	${git} "${DIR}/patches/imx_dts/0058-ARM-dts-imx6q-dl-add-a-DTE-uart-pinctrl-for-uart2.patch"
	${git} "${DIR}/patches/imx_dts/0059-ARM-dts-enable-the-uart2-for-imx6q-arm2.patch"
	${git} "${DIR}/patches/imx_dts/0060-ARM-dts-imx-share-pad-macro-names-between-imx6q-and-.patch"
	${git} "${DIR}/patches/imx_dts/0061-ARM-dts-add-more-imx6q-dl-pin-groups.patch"
	${git} "${DIR}/patches/imx_dts/0062-ARM-dts-imx6qdl-add-a-new-pinctrl-for-uart3.patch"
	${git} "${DIR}/patches/imx_dts/0063-ARM-dts-imx25-Make-lcdc-compatible-to-imx21-fb.patch"
	${git} "${DIR}/patches/imx_dts/0064-ARM-dts-imx6qdl-imx6sl-add-the-dma-property-for-uart.patch"
	${git} "${DIR}/patches/imx_dts/0065-ARM-dts-imx6qdl.dtsi-Add-usdhc1-pin-groups.patch"
	${git} "${DIR}/patches/imx_dts/0066-ARM-dts-imx6qdl.dtsi-Add-another-uart3-pin-group.patch"
	${git} "${DIR}/patches/imx_dts/0067-ARM-dts-imx6dl-wandboard-Add-SDHC1-and-SDHC2-ports.patch"
	${git} "${DIR}/patches/imx_dts/0068-ARM-dts-imx6dl-wandboard-Add-support-for-UART3.patch"
	${git} "${DIR}/patches/imx_dts/0069-ARM-dts-i.MX51-Add-WEIM-node.patch"
	${git} "${DIR}/patches/imx_dts/0070-ARM-dts-imx27-Add-core-voltages.patch"
	${git} "${DIR}/patches/imx_dts/0071-ARM-dts-imx51-babbage-Pass-a-real-clock-to-the-codec.patch"
	${git} "${DIR}/patches/imx_dts/0072-ARM-dtsi-enable-ahci-sata-on-imx6q-platforms.patch"
	${git} "${DIR}/patches/imx_dts/0073-drivers-bus-imx-weim-Remove-private-driver-data.patch"
	${git} "${DIR}/patches/imx_dts/0074-drivers-bus-imx-weim-Simplify-error-path.patch"
	${git} "${DIR}/patches/imx_dts/0075-drivers-bus-imx-weim-use-module_platform_driver_prob.patch"
	${git} "${DIR}/patches/imx_dts/0076-drivers-bus-imx-weim-Add-missing-platform_driver.own.patch"
	${git} "${DIR}/patches/imx_dts/0077-drivers-bus-imx-weim-Add-support-for-i.MX1-21-25-27-.patch"
	${git} "${DIR}/patches/imx_dts/0078-ARM-i.MX6-call-ksz9021-phy-fixup-for-all-i.MX6-board.patch"
	${git} "${DIR}/patches/imx_dts/0079-ARM-i.MX6-add-ethernet-phy-fixup-for-AR8031.patch"
	${git} "${DIR}/patches/imx_dts/0080-ARM-i.MX6-add-ethernet-phy-fixup-for-KSZ9031.patch"
	${git} "${DIR}/patches/imx_dts/0081-ARM-imx_v6_v7_defconfig-Select-CONFIG_NOP_USB_XCEIV-.patch"
	${git} "${DIR}/patches/imx_dts/0082-ARM-i.MX6Q-Use-ENET_CLK_SEL-defines-in-imx6q_1588_in.patch"
	${git} "${DIR}/patches/imx_dts/0083-ARM-imx_v6_v7_defconfig-Enable-FSL_LPUART-support.patch"
	${git} "${DIR}/patches/imx_dts/0084-ARM-imx_v6_v7_defconfig-Enable-LVDS-Display-Bridge.patch"
	${git} "${DIR}/patches/imx_dts/0085-ARM-i.MX6DL-parent-LDB-DI-clocks-to-PLL5-on-i.MX6S-D.patch"
	${git} "${DIR}/patches/imx_dts/0086-ARM-imx_v6_v7_defconfig-Enable-VPU-driver.patch"
	${git} "${DIR}/patches/imx_dts/0087-ARM-imx_v4_v5_defconfig-Select-CONFIG_MACH_IMX25_DT.patch"
	${git} "${DIR}/patches/imx_dts/0088-ARM-imx-let-L2-initialization-be-a-common-function.patch"
	${git} "${DIR}/patches/imx_dts/0089-ARM-imx-use-imx-specific-L2-init-function-on-imx6sl.patch"
	${git} "${DIR}/patches/imx_dts/0090-ARM-imx_v6_v7_defconfig-enable-WEIM-driver.patch"
	${git} "${DIR}/patches/imx_dts/0091-ARM-imx-fix-imx_init_l2cache-storage-class.patch"
	${git} "${DIR}/patches/imx_dts/0092-ARM-imx-Select-MIGHT_HAVE_CACHE_L2X0.patch"
	${git} "${DIR}/patches/imx_dts/0093-ARM-imx-add-common-clock-support-for-fixup-div.patch"
	${git} "${DIR}/patches/imx_dts/0094-ARM-imx-add-common-clock-support-for-fixup-mux.patch"
	${git} "${DIR}/patches/imx_dts/0095-ARM-imx6-change-some-clocks-to-fixup-clocks.patch"
	${git} "${DIR}/patches/imx_dts/0096-ARM-imx-clk-pllv3-improve-the-timeout-waiting-method.patch"
	${git} "${DIR}/patches/imx_dts/0097-ARM-mxs-Simplify-detection-of-CrystalFontz-boards.patch"
	${git} "${DIR}/patches/imx_dts/0098-ARM-mxs-dt-Add-Crystalfontz-CFA-10056-device-tree.patch"
	${git} "${DIR}/patches/imx_dts/0099-ARM-mxs-dt-Add-Crystalfontz-CFA-10058-device-tree.patch"
	${git} "${DIR}/patches/imx_dts/0100-ARM-mxs-dt-cfa10037-make-hogpins-grabbed-by-respecti.patch"
	${git} "${DIR}/patches/imx_dts/0101-ARM-mxs-dt-cfa10049-make-hogpins-grabbed-by-respecti.patch"
	${git} "${DIR}/patches/imx_dts/0102-ARM-mxs-dt-cfa10055-make-hogpins-grabbed-by-respecti.patch"
	${git} "${DIR}/patches/imx_dts/0103-ARM-mxs-dt-cfa10057-remove-hogpins.patch"
	${git} "${DIR}/patches/imx_dts/0104-ARM-mxs-dt-cfa10036-make-hogpins-grabbed-by-respecti.patch"
	${git} "${DIR}/patches/imx_dts/0105-ARM-mxs-Add-backlight-support-for-M28EVK.patch"
	${git} "${DIR}/patches/imx_dts/0106-ARM-dts-mxs-remove-old-DMA-binding-data-from-client-.patch"
	${git} "${DIR}/patches/imx_dts/0107-ARM-dts-imx-remove-old-DMA-binding-data-from-gpmi-no.patch"
	${git} "${DIR}/patches/imx_dts/0108-ARM-dts-imx-add-tempmon-node-for-imx6q-thermal-suppo.patch"
	${git} "${DIR}/patches/imx_dts/0109-ARM-mxs-pm-Include-pm.h.patch"
	${git} "${DIR}/patches/imx_dts/0110-ARM-dts-imx23-evk-enable-USB-PHY-and-controller.patch"
	${git} "${DIR}/patches/imx_dts/0111-ARM-dts-imx23-evk-enable-Low-Resolution-ADC.patch"
	${git} "${DIR}/patches/imx_dts/0112-ARM-dts-imx23-olinuxino-enable-Low-Resolution-ADC.patch"
	${git} "${DIR}/patches/imx_dts/0113-ARM-imx-add-low-level-debug-for-vybrid.patch"
	${git} "${DIR}/patches/imx_dts/0114-ARM-dts-imx6-Add-support-for-imx6q-wandboard.patch"
	${git} "${DIR}/patches/imx_dts/0115-ARM-dts-imx6q-wandboard-Add-sata-support.patch"
	${git} "${DIR}/patches/imx_dts/0116-ARM-dts-imx-add-LVDS-panel-for-imx6qdl-sabresd.patch"
	${git} "${DIR}/patches/imx_dts/0117-ARM-dts-imx-use-generic-DMA-bindings-for-SSI-nodes.patch"
	${git} "${DIR}/patches/imx_dts/0118-ARM-imx6q-add-spdif-gate-clock.patch"
	${git} "${DIR}/patches/imx_dts/0119-ARM-imx6q-add-cko2-clocks.patch"
	${git} "${DIR}/patches/imx_dts/0120-ARM-imx6q-add-the-missing-cko-output-selection.patch"
	${git} "${DIR}/patches/imx_dts/0121-ARM-imx6q-remove-board-specific-CLKO-setup.patch"
	${git} "${DIR}/patches/imx_dts/0122-ARM-dts-imx6qdl-sabresd-Allow-buttons-to-wake-up-the.patch"
	${git} "${DIR}/patches/imx_dts/0123-ARM-dts-i.MX27-Using-wdog_ipg_gate-clock-source-for-.patch"
	${git} "${DIR}/patches/imx_dts/0124-ARM-dts-i.MX27-Remove-optional-ptp-clock-source-for-.patch"
	${git} "${DIR}/patches/imx_dts/0125-ARM-dts-i.MX27-Add-label-to-CPU-node.patch"
	${git} "${DIR}/patches/imx_dts/0126-ARM-dts-i.MX27-Increase-clock-latency-value.patch"
	${git} "${DIR}/patches/imx_dts/0127-ARM-dts-i.MX27-Remove-clock-name-from-CPU-node.patch"
	${git} "${DIR}/patches/imx_dts/0128-ARM-dts-imx27-phytec-phycore-som-Fix-regulator-setti.patch"
	${git} "${DIR}/patches/imx_dts/0129-ARM-imx6q-add-vdoa-gate-clock.patch"
	${git} "${DIR}/patches/imx_dts/0130-ARM-dts-mxs-Add-spi-alias.patch"
	${git} "${DIR}/patches/imx_dts/0131-ARM-dts-imx-ocram-size-is-different-between-imx6q-an.patch"
	${git} "${DIR}/patches/imx_dts/0132-ARM-imx-add-ocram-clock-for-imx53.patch"
}

imx () {
	echo "dir: imx"
	#v7: http://www.spinics.net/lists/linux-ide/msg45738.html
	#http://patchwork.ozlabs.org/project/linux-ide/list/
#	${git} "${DIR}/patches/imx/0001-ARM-dtsi-enable-ahci-sata-on-imx6q-platforms.patch"
	${git} "${DIR}/patches/imx/0002-ARM-imx6q-update-the-sata-bits-definitions-of-gpr13.patch"
	${git} "${DIR}/patches/imx/0003-sata-imx-add-ahci-sata-support-on-imx-platforms.patch"
}

omap () {
	echo "dir: omap"
	#fix panda/omap4 usb host...
	${git} "${DIR}/patches/omap/0001-ARM-OMAP2-Provide-alias-to-USB-PHY-clock.patch"

	#[PATCH v10] reset: Add driver for gpio-controlled reset pins
	${git} "${DIR}/patches/omap/0002-reset-Add-driver-for-gpio-controlled-reset-pins.patch"
	${git} "${DIR}/patches/omap/0003-usb-phy-nop-Use-RESET-Controller-for-managing-the-re.patch"
	${git} "${DIR}/patches/omap/0004-ARM-dts-omap3-beagle-Use-reset-gpio-driver-for-hsusb.patch"
	${git} "${DIR}/patches/omap/0005-ARM-dts-omap4-panda-Use-reset-gpio-driver-for-hsusb1.patch"
	${git} "${DIR}/patches/omap/0006-ARM-dts-omap5-uevm-Use-reset-gpio-driver-for-hsusb2_.patch"
	${git} "${DIR}/patches/omap/0007-ARM-dts-omap3-beagle-xm-Add-USB-Host-support.patch"
	${git} "${DIR}/patches/omap/0008-ARM-dts-omap3-beagle-Make-USB-host-pin-naming-consis.patch"

	#omap3430: lockup on reset fix...
	${git} "${DIR}/patches/omap/0009-omap2-twl-common-Add-default-power-configuration.patch"
	${git} "${DIR}/patches/omap/0010-ARM-OMAP-Beagle-use-TWL4030-generic-reset-script.patch"

	#omap4: fix video..
	${git} "${DIR}/patches/omap/0011-ARM-OMAP-dss-common-fix-Panda-s-DVI-DDC-channel.patch"
	${git} "${DIR}/patches/omap/0012-ARM-OMAP2-Remove-legacy-DSS-initialization-for-omap4.patch"
}

dts () {
	echo "dir: dts"
	#omap: https://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/
	#imx: https://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=summary
	${git} "${DIR}/patches/dts/0001-ARM-imx-Enable-UART1-for-Sabrelite.patch"
}

saucy () {
	echo "dir: saucy"
	#Ubuntu Saucy: so Ubuntu decided to enable almost every Warning -> Error option...
	${git} "${DIR}/patches/saucy/0001-saucy-error-variable-ilace-set-but-not-used-Werror-u.patch"
}

arm
drivers
imx_dts
imx
omap
dts
saucy

echo "patch.sh ran successful"
