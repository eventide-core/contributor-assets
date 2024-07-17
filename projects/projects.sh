source ./projects/ruby-projects.sh
source ./projects/mruby-projects.sh
source ./projects/other-projects.sh
source ./projects/template-projects.sh

projects=(
  "${ruby_projects[@]}"
  "${mruby_projects[@]}"
  "${other_projects[@]}"
  "${template_projects[@]}"
)
