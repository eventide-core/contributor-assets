source ./projects/other-projects.sh
source ./projects/mruby-projects.sh
source ./projects/native-projects.sh

projects=(
  "${other_projects[@]}"
  "${mruby_projects[@]}"
  "${native_projects[@]}"
)
