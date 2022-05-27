*** Settings ***
Library    RequestsLibrary

*** Variables ***
${base_url}     https://petstore.swagger.io
${petId}

*** Keywords ***
Check_pet
    [Arguments]  ${id}  ${status}
    ${response}=  get request  petstore_api  /v2/pet/${id}
    ${status_code}=  convert to string  ${response.status_code}
    should be equal  ${status_code}  ${status}

Get_status_code
    [Arguments]  ${response}
    ${status_code}=  convert to string  ${response.status_code}
    [Return]  ${status_code}
