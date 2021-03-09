# Currency converter

This is a technical task implementation written as a part of a technical interview for TransferGo. It is a currency converter app that communicates with the TrasferGo API.

## Architecture and implementation
The architecture used in this project is MVVM. Along side MVVM RxSwift is used to have a reactive and responsive app.
For navigation purposes a basic coordinator is implemented.
Unit test target is added with basic test functionality.
App supports iOS versions 12.1 and greater.

## Functionality

The app consists of one screen on which the user has an option to choose:

	1. the currency from which he wants to convert

	2. the currency to which he wants to convert

	3. amount that he wants to convert

Clicking on the convert button an API request is made (along with the conversion) and subsequently the converted amount is shown along with the exchange rate.

The user is now free to change the amounts and make instant conversions because of the availiability of the exchange rate.

At the same time he is able to change the currencies from the initial ones.
NOTE to follow here: after the currency change the user needs to click on the "Convert" button again in order to fetch the exchange rate for the newly selected currencies.

## Usage

There are two ways how to use the solution.

1. Download the zip file and unarchive it
2. Clone the repository on to your local machine

After either of those two steps position yourself in the root directory and run 
```bash
pod install
```

If cocoapods are missing in your terminal follow the instructions here: https://cocoapods.org/

When the pods get installed run the app in Xcode.

Cmd + 6 to position yourself in Xcode to see the avilable tests and run them to check if everything is fine.

## Missing

Things missing because I didn't have enough time:

1. texts indiciating which currency is in which text field. -> I can explain how I would implement that
2. network activity indicator showing when a network call is made. 

Different implementation than the mockup:

1. missing image resources are exchanged with new images
2. different description text
3. text fields are implemented one below the other instead of side by side (stack view implementation possible here if I had more time)
4. styling for some elements is not the same as on the mockup
