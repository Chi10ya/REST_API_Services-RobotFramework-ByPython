# POST REQUEST

*** Settings ***
Library     RequestsLibrary
Library     Collections


*** Variables ***

${base_url}=    https://reqres.in


*** Test Cases ***
Put_User_Details
    create session  mySession   ${base_url}

    ${body}=    create dictionary   id=4    first_name=Eve Stefen Son One
    ${header}=  create dictionary   Content-Type=application/json
    ${response}=    put request    mySession   /api/users/4   data=${body}    headers=${header}

    log to console  ${response.status_code}
    log to console  ${response.content}


#VALIDATIONS
    # Validating the response Status Code

        ${status_code}=     convert to string   ${response.status_code}
        should be equal     ${status_code}  200

    # Validating the value in the Response Content

        ${res_body}=    convert to string   ${response.content}
        should contain      ${res_body}     Eve Stefen Son One