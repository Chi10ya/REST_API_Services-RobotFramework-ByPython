//Part 6
// How to validate data in JSON File
// How to validate Complex Data in JSON Response

// http://jsonpathfinder.com ==> Website for to validate the JSON file and to generate / find the JSON path
// http://jsonpath.com


*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     JSONLibrary
Library     os

*** Variables ***
${jsonFilePath}=    C:\\Users\\chaitanya.mohammad\\PycharmProjects\\APIAutomation_BySDET_RobotFramework\\REST_API_TestCases\\JSON_File_Sample_Format.json
${countriesBaseURL}=    https://restcountries.eu


*** Test Cases ***
# Validating data in JSON File
TC5_ValidateJSON_File:

    ${loadJSONFile}=    load json from file     ${jsonFilePath}

    ${getFirstName}=    get value from json      ${loadJSONFile}    $.firstName
    log to console      ${getFirstName}
    should be equal     ${getFirstName[0]}      Chaitanya

    ${getStreetName}=    get value from json      ${loadJSONFile}    $.Address.StreetName
    log to console      ${getStreetName}
    should be equal     ${getStreetName[0]}      Fermoy

    ${getMobileNumber}=    get value from json      ${loadJSONFile}    $.ContactNumber[0].MobileNumber
    log to console      ${getMobileNumber}
    should be equal     ${getMobileNumber[0]}      0556174499


# Test case for to validate the values in the Service - Response.
TC5_ValidateJSON_In_The_Response:

    create session  weatherSession   ${countriesBaseURL}
    ${response}=    get request     weatherSession      /rest/v2/alpha/IRL

    ${json_object}=     to json     ${response.content}

    # Single Data Validation
    ${country_name}=    get value from json     ${json_object}      $.name
    log to console      ${country_name[0]}
    should be equal     ${country_name[0]}      Ireland

    # Single data validation in array
    ${border}=      get value from json     ${json_object}      $.borders[0]
    log to console      ${border[0]}
    should contain any      ${border[0]}    GBR
    should not contain any  ${border[0]}    USA




