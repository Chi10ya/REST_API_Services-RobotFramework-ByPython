//Part 7
// How to validate data in XML File
// How to validate data in XML Response

*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     os
Library     XML


*** Variables ***
${xmlFileLocation}=     C:\\Users\\chaitanya.mohammad\\PycharmProjects\\APIAutomation_BySDET_RobotFramework\\REST_API_TestCases\\XML_file_Sample_Employees.xml
${base_url}     http://thomas-bayer.com
#${relative_url}     /sqlrest/CUSTOMER/15

*** Test Cases ***
# Validating data in XML File
TC6_ValidateXMl_File:

    ${xmlObj}=      parse xml       ${xmlFileLocation}

    # Validations
    # Val1 - Check the single element value

    # Approach 1:
    ${empFirstName}=    get element text    ${xmlObj}   .//employee[1]/firstName
    should be equal     ${empFirstName}     Chaitanya

    # Approach 2:
    ${empFirstName}=    get element    ${xmlObj}   .//employee[1]/firstName
    should be equal     ${empFirstName.text}     Chaitanya

    # Approach 3:
    element text should be      ${xmlObj}      Chaitanya    .//employee[1]/firstName

    # Val 2- check number of elements
    ${count}=   get element count   ${xmlObj}   .//employee
    should be equal as integers     ${count}    1

    # Val3 - Check attribute presence
    element attribute should be     ${xmlObj}   ID  212224  .//employee[1]

    # Val4 - Check values of child elements
    ${childElements}=   get child elements  ${xmlObj}   .//employee[1]
    should not be empty     $[childElements]
        ${fName}=       get element text    ${childElements[0]}
        ${lName}=       get element text    ${childElements[1]}
        ${title}=       get element text    ${childElements[2]}
        ${country}=     get element text  ${childElements[3]}
        ${city}=       get element text     ${childElements[4]}

        log to console       ${fName}
        log to console       ${lName}
        log to console       ${title}
        log to console       ${country}
        log to console       ${city}

        # Validating the values
        should be equal     ${fName}    Chaitanya
        should be equal     ${lName}    Mohammad
        should be equal     ${title}    Sr.Quality Assurance Analyst
        should be equal     ${country}    Ireland
        should be equal     ${city}    Cork

# Validating data in XML Response
TC6_ValidateXMl_Response:

    create session      myXMLResponseSession    ${base_url}
    ${response}=        get request     myXMLResponseSession    /sqlrest/CUSTOMER/15
    ${XMLString}=       convert to string   ${response.content}
    ${XMLObj}=     parse xml   ${XMLString}

    # Check single Element value
    element text should be ${XMlObj}   15  .//ID

    # Check multiple values
    ${childElements}=  get child elements  ${XMLObj}
    should not be empty ${childElements}

    ${id}=  get element text    ${childElements[0]}
    ${fName}=   get element text    ${childElements[1]}
    ${lName}=   get element text    ${childElements[2]}
    ${street}=  get element text    ${childElements[3]}
    ${city}=    get element text    ${childElements[4]}

    should be equal     ${id}   15
    should be equal     ${fName}   Bill
    should be equal     ${lName}   Clancy
    should be equal     ${street}   319 Upland PL.
    should be equal     ${city}     Seattle