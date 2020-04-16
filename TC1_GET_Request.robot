
# GET REQUEST

*** Settings ***

Library     RequestsLibrary
Library     Collections


*** Variables ***

${base_url}     http://restapi.demoqa.com
${relative_url}     /utilities/weather/city/
${city}     Cork


*** Test Cases ***

Get_WeatherInfo
    create session  mySession   ${base_url}
    ${weatherResponse}=     get request     mySession  ${relative_url}${city}
    log to console  ${weatherResponse.status_code}
    log to console  ${weatherResponse.content}
    log to console  ${weatherResponse.headers}

# Validations
    # Validating the response Status Code

        ${status_code}=     convert to string      ${weatherResponse.status_code}
        should be equal     ${status_code}  200

    # Validating the value in the Response Content

        ${res_body}=    convert to string    ${weatherResponse.content}
        should contain      ${res_body}     Cork

    # Validating the Key and Value in Headers
        ${contentTypeValue}=    get from dictionary     ${weatherResponse.headers}     Content-Type
        ${serverValue}=    get from dictionary     ${weatherResponse.headers}     Server
        should be equal     ${contentTypeValue}    application/json
        should be equal     ${serverValue}    nginx

