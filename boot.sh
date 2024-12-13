# set -e

ascii_art='
  ________________  .____       _____
 /   _____\_____  \ |    |     /  _  \
 \_____  \ /   |   \|    |    /  /_\  \
 /        /    |    |    |___/    |    \
/_______  \_______  |_______ \____|__  /
        \/        \/        \/       \/
'

# echo "$ascii_art"
# Define the color gradient (shades of cyan and blue)
colors=(
	'\033[38;5;81m' # Cyan
	'\033[38;5;75m' # Light Blue
	'\033[38;5;69m' # Sky Blue
	'\033[38;5;63m' # Dodger Blue
	'\033[38;5;57m' # Deep Sky Blue
	'\033[38;5;51m' # Cornflower Blue
	'\033[38;5;45m' # Royal Blue
)

# Split the ASCII art into lines
IFS=$'\n' read -rd '' -a lines <<<"$ascii_art"

# Print each line with the corresponding color
for i in "${!lines[@]}"; do
	color_index=$((i % ${#colors[@]}))
	echo -e "${colors[color_index]}${lines[i]}"
done


echo -e '\033[0m' # Set to default color
echo "Begin installation (or abort with ctrl+c)..."

ROOT=~/.local/share/sola

rm -rf $ROOT
mkdir $ROOT
# cp -r ./* $ROOT >/dev/null
git clone https://github.com/besya/sola.git ~/.local/share/sola >/dev/null

source $ROOT/install.sh
