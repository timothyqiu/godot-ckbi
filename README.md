# Godot Color-Keyed BMP Importer

[![MIT license](https://img.shields.io/badge/license-MIT-blue.svg)](https://lbesson.mit-license.org/)

Import color-keyed BMP image as texture with transparency. Useful for legacy
assets that use color-key / chroma-key instead of alpha channel.

To install, download the ZIP archive, extract it, and move the `addons/` folder it
contains into your project folder. Then, enable the plugin in project settings.

To use this importer, select the BMP file, change Import As to
"Color-Keyed BMP" in the Import dock, set the import options
and click Reimport.

The BMP file will be imported as a regular `StreamTexture` resource,
with pixels matching the color-key replaced by transparent pixels.

## Import Options

* **Color Key**
	*	The color key (transparent pixel) in the image.

---

# Godot 透明色 BMP 导入器

[![MIT license](https://img.shields.io/badge/license-MIT-blue.svg)](https://lbesson.mit-license.org/)

将使用透明色的 BMP 导入为包含透明度的纹理。适用于使用透明色/色键而不是透明通道的古老的图片素材。

安装方法：下载 ZIP 包，解压后将 `addons/` 文件夹移动到你的项目文件夹中，然后在项目设置中启用本插件。

使用方法：选中 BMP 文件，在「导入」面板中将「导入为」设置为「Color-Keyed BMP」，设置好导入选项后点击「重新导入」。

BMP 文件会被导入为普通的 `StreamTexture` 资源，使用透明色的像素已被替换为透明像素。

## 导入选项

* **Color Key**
	* 图片的透明色（也叫关键色、色键）。
