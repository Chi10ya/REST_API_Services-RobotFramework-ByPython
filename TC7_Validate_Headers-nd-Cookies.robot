# Validating Headers and Cookies

*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${baseURL}=     http://jsonplaceholder.typicode.com

*** Test Cases ***
TestHeaders:

    create session      mySession   ${baseURL}
    ${response}=    get request     mySession   /photos

    log to console      ${response.headers}
    ${contentTypeValue}=    get from dictionary     ${response.headers}     Content-Type
    should be equal     ${contentTypeValue}     application/json; charset=utf-8

    ${contentEncodeValue}=  get from dictionary     ${response.headers}     Content-Encoding
    should be equal     ${contentEncodeValue}   gzip

Test Cookies:

    create session      mySession   ${baseURL}
    ${response}=    get request     mySession   /photos

    log to console      ${response.cookies}
    ${cookieValue}=     get from dictionary     ${response.cookies}     __cfduid
    log to console      ${cookieValue}

