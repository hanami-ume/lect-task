#!/usr/bin/env bash
# 在练习服务器上布置 lect-task 练习环境（需 root）。
# 用法：sudo bash deploy/setup_server.sh [仓库目录，默认当前目录]
set -euo pipefail
SRC="${1:-$(cd "$(dirname "$0")/.." && pwd)}"
DEST=/opt/lect-task
PLAYER=player

# 1. 部署题面与附件（不含 solutions）
mkdir -p "$DEST"
rsync -a --delete --exclude 'solutions' --exclude '.git' "$SRC"/challenges "$DEST"/
cp -r "$SRC"/tools "$DEST"/tools
chmod -R a+rX "$DEST"

# 2. 练习用户
if ! id "$PLAYER" &>/dev/null; then
  useradd -m -s /bin/bash "$PLAYER"
fi
# 把题目软链到用户主目录（只读）
ln -sfn "$DEST"/challenges /home/$PLAYER/challenges
ln -sfn "$DEST"/tools /home/$PLAYER/tools
cat > /home/$PLAYER/README.txt <<'TXT'
欢迎做题。题目在 ~/challenges/ ，离线工具在 ~/tools/ 。
每题目录下有 README.md（题面）。祝顺利。
TXT
chown -R $PLAYER:$PLAYER /home/$PLAYER/README.txt

echo "完成。学员可 ssh $PLAYER@<本机IP> ，题目在 ~/challenges/"
