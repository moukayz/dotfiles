## git clean

- 查看将要删除的文件和文件夹（不会真的删除）

  ```bash
  git clean -n
  ```

- 删除**ignored files(directories)**

  ```bash
  git clean -fdX
  ```

- 删除**ignored and non-ignored files(directories)**

  ```bash
  git clean -fdx
  ```


## git checkout

- 在远程仓库中创建分支并在本地切换到该分支(eg. develop)

  ```bash
  git checkout --track origin/develop
  ```

- 在本地新建分支并切换分支

  ```bash
  git checkout -b new_branch
  ```

## git submodule

- 添加子模块到当前目录

  ```bash
  git submodule add https://git-repository...
  ```

- 下载子模块代码

  ```bash
  git submodule update --init --recursive
  # --recursive 表示如果子模块中还包含子模块，则递归克隆
  ```

- 克隆主仓时同时克隆子模块

  ```bash
  git clone --recursive https://my-repository
  ```

## git reset

- 将staged文件转为unstage状态

  ```bash
  git reset HEAD file-to-unstage
  ```

- 将仓库重置到某一次commit状态(**重置后，COMMIT到HEAD之间所有的commit历史记录都将丢失**)

  ```bash
  git reset MODE=--mixed COMMIT
  # eg. git reset --soft HEAD
  ```

  MODE:

  - --soft:仅重置仓库到COMMIT，**git索引（staged文件）和工作目录下已修改文件不受影响**
  - --mixed：重置仓库到COMMIT，重置git索引。**工作目录下已修改文件不受影响**

  - --hard：重置仓库到COMMIT，重置git索引，重置工作目录下对文件的修改（所有修改丢失)。**untracked文件不受影响**

## git push

- 将本地新建的分支push到远程仓库

  ```bash
  git push --set-upstream origin new_branch
  ```

## git diff

- 比较工作目录与staged区的差异，即显示已修改但还未stage的内容

  ```bash
  git diff [--] [<path>] # 后跟文件路径可显示具体文件或文件夹的变化
  ```

- 比较staged区与上一次commit的差异，即显示下一次commit将会修改的内容（同`--staged`）

  ```bash
  git diff --cached [--] [<path>]
  ```

## git log

- 详细显示最近n次提交的记录

  ```bash
  git log -p -2 # 显示最近2次的提交记录
  ```

- 简要显示每次提交的信息（仅列出修改的文件名）

  ```bash
  git log --stat [--other-options]
  ```

- 与日志输出格式相关的选项
  - `--stat`: 显示每次提交的汇总信息（列出修改的文件名，及每个文件发生的修改次数，eg. 新增多少行，删除多少行）
  - `--shortstat`：显示每次提交总共发生的文件修改次数（不显示文件名）
  - `--name-only`：仅显示每次提交发生修改的文件名
  - `--name-status`：显示每次提交发生修改的文件，及修改方式（删除、新增、修改）
  - `--abbrev-commit`：简要显示每次提交的SHA-1值（显示前6位）
  - `--oneline`: 将每次提交的信息简化为一行
  - `--graph`: 以ASCII图形方式显示提交记录的变化

## git commit

- 修改最近一次提交的内容（覆盖提交注释）

  ```bash
  git commit --amend -m "some message"
  ```

- 修改已经push到远端的提交

  ```bash
  # git push will aborted , instead use
  git push --force-with-lease # this will aborted if someone else pushed to remote
  ```

## git remote

- 添加远程仓库

  ```bash
  git remote add <repo-name> <repo-address>
  ```

- 显示远程仓库列表

  ```bash
  git remote -v
  ```

- 显示指定远程仓库信息(仓库地址、分支情况、本地分支与远程分支的对应情况等)

  ```bash
  git remote show origin
  ```

- 重命名远程仓库

  ```bash
  git remote rename <old-name> <new-name>
  ```

- 拉取远程分支到本地
> 当使用'single-branch'方式clone后，`git fetch`无法获取到除当前clone分支外的其他分支(shallow clone）需要手动恢复至full clone

  ```bash
  git fetch --unshallow   # 恢复full clone
  git remote set-branches origin '*' # 添加除当前分支外的其他分支
  git fetch

## git branch

- 删除分支

  ```bash
  git branch -d branch_name # 只能删除已merge的分支
  git branch -D branch_name # 强制删除，无论分支是否merge
  ```

- 显示各分支SHA1值，以及本地分支和对应远程分支的差异（ahead, behind?）

  ```bash
  git branch -v
  ```


## Msics

- 只克隆某一远程分支

  ```bash
  git clone --single-branch -b branch_name https://git_repo_address
  ```

  **如此后无法获取和切换到其他远程分支**

- **single-branch**克隆后添加其他分支（该分支已存在于远程仓库）

  ```bash
  git remote set-branches --add origin another_branch # 添加分支
  git fetch origin # 更新远程分支列表
  ```

  克隆该分支到本地并切换

  ```bash
  git checkout another_branch
  ```

- 在commit历史中搜索某文件
  ```bash
  git log --all --full-history -- <path-to-file> # 精确的文件路径
  git log --all --full-history -- "**/my-folder/*" # 搜索my-folder文件夹下的所有文件
  ```

- 显示某一commit中某文件的内容
  ```bash
  git show <commit-SHA> -- <path-to-file>
  ```

- 将某文件恢复到某一commit时的状态
  ```bash
  git checkout <commit-SHA>^ -- <path-to-file>
  ```

## git log

- 根据文件变化类型进行过滤
  ```bash
  git log --diff-filter=filter
  # filter:
  # A: Added
  # C: Copied
  # D: Deleted
  # M: Modified
  # R: Renamed
  # ...
  git log --diff-filter=D # show commits that deleted files

  # lowercase filter represents to exclude this type
  git log --diff-filter=d # show commits that didn't deleted files

- 仅显示改动的文件名和改动类型
  ```bash
  git log --name-only   # only file name
  git log --name-status # only file name and status of change
## git config

- 暂时启用git密码缓存

  ```bash
  git config credential.helper 'cache'
  git config credential.helper 'cache --timeout=300' # out of date after 300s
  ```

- git支持长文件路径

  ```bash
  git config core.longpaths true
  ```

- 设置push操作上传大小限制

  ```bash
  git config http.postbuffer 524288000
  ```




