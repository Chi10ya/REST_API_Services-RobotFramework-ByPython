# GET REQUEST

*** Settings ***

Library     RequestsLibrary
Library     Collections


*** Variables ***

${base_url}=    https://reqres.in


*** Test Cases ***

Delete_User_Details
    create session  mySession   ${base_url}

    ${userResponse}=     delete request     mySession  /api/users/5
    log to console  ${userResponse.status_code}
    log to console  ${userResponse.content}
    log to console  ${userResponse.headers}

# Validations
    # Validating the response Status Code

        ${status_code}=     convert to string      ${userResponse.status_code}
        should be equal     ${status_code}  200

    # Validating the value in the Response Content

        ${res_body}=    convert to string    ${userResponse.content}
        should contain      ${res_body}     Record Deleted Successfully