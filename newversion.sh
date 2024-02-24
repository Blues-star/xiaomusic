#!/bin/bash

set -e

version_file=./pyproject.toml
# 获取当前版本号
current_version=$(grep -oE "version = \"[0-9]+\.[0-9]+\.[0-9]+\"" $version_file | cut -d'"' -f2)
echo "当前版本号: "$current_version

# 将版本号分割成三部分
major=$(echo $current_version | cut -d'.' -f1)
minor=$(echo $current_version | cut -d'.' -f2)
patch=$(echo $current_version | cut -d'.' -f3)

echo "major: $major"
echo "minor: $minor"
echo "patch: $patch"

# 将补丁号加1
patch=$((patch + 1))

# 生成新版本号
new_version="$major.$minor.$patch"

# 将新版本号写入文件
sed -i "s/version.*/version = \"$new_version\"/g" $version_file

echo "新版本号：$new_version"

git diff
git add version_file
git commit -m "new version v$version"
git tag v$version
git push -u origin main --tags
