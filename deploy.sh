#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm run docs:build

# 进入生成的文件夹
cd docs/.vuepress/dist

# 如果是发布到自定义域名
echo 'docs.testcross.top' > CNAME

git init
git add -A5
git commit -m 'deploy'

# 如果发布到 https://<USERNAME>.github.io
# git push -f git@github.com:<USERNAME>/<USERNAME>.github.io.git master
##https://github.com/testcross-01/docs.git

# 如果发布到 https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:testcross-01/docs.git master:gh-pages
# git push -f git@github.com:<USERNAME>/<REPO>.git master:gh-pages
cd -