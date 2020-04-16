
# POST REQUEST

*** Settings ***
Library     RequestsLibrary
Library     Collections


*** Variables ***
${base_url}=    http://restapi.demoqa.com/customer
#${relative_url}=    /register


*** Test Cases ***
Post_Customer_Registration
    create session  mySession   ${base_url}

    ${body}=    create dictionary   FirstName=Chaitan22401      LastName=Chaitan22401     UserName=Chaitan22401    Password=Chaitan22401   Email=chaitan22401@gmail.com    Phone=020293200001
    ${header}=  create dictionary   Content-Type=application/json
    ${response}=    post request    mySession   /register    data=${body}    headers=${header}

    log to console  ${response.status_code}
    log to console  ${response.content}

#VALIDATIONS
    # Validating the response Status Code

        ${status_code}=     convert to string   ${response.status_code}
        should be equal     ${status_code}  201

    # Validating the value in the Response Content
        ${res_body}=    convert to string   ${response.content}
        should contain      ${res_body}     OPERATION_SUCCESS
        should contain      ${res_body}     Operation completed successfully