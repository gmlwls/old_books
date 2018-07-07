#6월 26일 양곤 댓글 구현
comment 모델과 controller books/show.html.erb에 댓글 쓰고 보이는 부분, comments/create.js.erb & _item.html.erb
book.rb user.rb comment.rb에 model relation관계 표시.

#6월 27일 양곤 devise에 받을 정보 추가
기존devise모델에 studentid(학번), school(학과)를 추가하였음. application_controller.rb에 whitelist추가해줬고, devise/edit.html.erb 와 new.html.erb에 추가해줬음. books/show.html.erb에 학번과 학과 정보도 드러나게 고쳤음.