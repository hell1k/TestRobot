*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     ../resources/CustomLibrary.py
Resource    ../resources/Resources.robot

*** Test Cases ***
# Добавляем нового питомца в базу и проверяем, что он добавился
Create_new_pet
    ${petId}=  get_random_id
    ${pet_name}=  get_random_name
    Set global variable  ${petId}
    create session      petstore_api     ${base_url}
    ${body}=  create dictionary  id=${petId}  name=${pet_name}  status=available
    ${header}=  create dictionary  Content-Type=application/json
    ${response}=  post request  petstore_api  /v2/pet  data=${body}  headers=${header}
    ${status_code}=  get_status_code  ${response}
    should be equal  ${status_code}  200
    check_pet  ${petId}  200

#Питомца купили и дали ему новое имя - переименовываем и проверяем, что тело ответа содержит новое имя и запись о питомце возвращает 200
Rename_pet
    create session  petstore_api  ${base_url}
    ${new_name}=  get_random_name  new_name
    ${body}=  create dictionary  id=${petId}  name=${new_name}  status=taken away
    ${header}=  create dictionary  Content-Type=application/json
    ${response}=  put request  petstore_api  /v2/pet  data=${body}  headers=${header}
    ${response_body}=  convert to string  ${response.content}
    should contain  ${response_body}  ${new_name}
    check_pet  ${petId}  200

#Удаляем запись о питомце и проверяем, что записи нет
Delete_pet
    create session  petstore_api  ${base_url}
    ${response}=  delete request  petstore_api  /v2/pet/${petId}
    ${status_code}=  get_status_code  ${response}
    should be equal  ${status_code}  200
    check_pet  ${petId}  404
