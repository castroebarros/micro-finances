Rails.application.routes.draw do
  mount Micro::Finances::Engine => "/micro-finances"
end
