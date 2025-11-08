# PNG to ICNS Converter

This script converts one or more `.png` images into macOS `.icns` application icons. It automatically generates the required iconset sizes and outputs a properly formatted `.icns` file.

## Requirements

* **macOS** (because this script uses `iconutil` to properly create small, medium and large icons)
* **ImageMagick** (provides the `magick` command used for initial image resizing)

### Install ImageMagick (Homebrew)

If you do not already have Homebrew installed:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then install ImageMagick:

```bash
brew install imagemagick
```

## Project Structure

```
project-folder/
├─ icns-converter.sh
├─ input/             # Place your source PNG images here
└─ file-output/       # Generated .icns files will be saved here
```

* The script will **automatically create** the `file-output` directory if it does not exist.
* The `input` directory **must exist** and contain one or more `.png` files.

## Usage

1. Place your `.png` image(s) inside the `input/` folder.
2. Make the script executable (first time only):

   ```bash
   chmod +x icns-converter.sh
   ```
3. Run the script:

   ```bash
   ./icns-converter.sh
   ```
4. The generated `.icns` files will appear in the `file-output/` directory.

## Notes

* PNG images should ideally be **at least 512×512** for best output quality.
* The script automatically generates required icon sizes for macOS.
* A test.png (the VNC logo) file has been included in the input directory to demonstrate the functionality of the script (feel free to delete it)

## Example Output

```
✓ Created: file-output/app-icon.icns
Conversion complete! All .icns files saved to 'file-output'
```

## Troubleshooting

| Issue                                            | Cause                     | Solution                                         |
| ------------------------------------------------ | ------------------------- | ------------------------------------------------ |
| `magick: command not found`                      | ImageMagick not installed | Install via Homebrew: `brew install imagemagick` |
| `Error: Input directory 'input' does not exist.` | Missing required folder   | Create `input/` and add your PNG files           |

