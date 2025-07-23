## Hey there,

This document is a rubyist adaptation of the original README file made for the Java API version. You can get access to it by clicking  [here](https://github.com/konduto/java-sdk/blob/master/README.md). **Konduto is a trademark, all rights reserved**. This project has no intention beyond helping ruby users to get easy access to Konduto's API through a simplified interface.

## Intro

Welcome! This document will explain how to integrate with Konduto's anti-fraud service so you can begin to spot fraud on your e-commerce website.

Our service uses the visitor's behavior to analyze browsing patterns and detect fraud. You will need to add a **JavaScript** snippet to your website and tag your pages, so we can see your visitors, and call our **REST API** to send purchases, so we can analyze them.

This document refers to the **Ruby SDK** used for our API.

## Requirements

* This API was tested with Ruby MRI version 2.

## Installation

To get started add Konduto's gem as a dependency in your **Gemfile**:

    gem 'konduto-ruby'

After that, run **bundle install**. If your are not using a Gemfile, run the following command

    $ gem install konduto-ruby

## Getting Started

When a customer makes a purchase you must send the order information to us so we can analyze it. We perform a real-time analysis and return you a **recommendation** of what to do next and a score, a numeric confidence level about that order.

While many of the parameters we accept are optional we recommend you send all you can, because every data point matters for the analysis. The **billing address** and **credit card information** are specially important, though we understand there are cases where you don't have that information.


## Set your API key

You will need an API key to authenticate the requests. Luckily for you the examples below have been populated with a working key, so you can just copy and paste to see how it works.

```ruby
# creates a Konduto instance, which is a class that communicates with our API by using HTTP methods.
konduto = KondutoRuby.new('T738D516F09CAB3A2C1EE') # T738D516F09CAB3A2C1EE is the API key
```

## Creating an order

`KondutoOrder` is a class that models the attributes and behavior of an order.

All entities involved in Konduto's analysis process (e.g customer, shopping cart, payment, etc.) inherit
from KondutoBase and you can get access to them by calling their name and passing a hash of attributes, as shown below.

```ruby
order = KondutoOrder.new({
          id: '123',
          totalAmount: 123.4,
          customer: customer # customer is an instance of KondutoCustomer
        })
```
One can also use the more conventional set-based approach as seen below.

```ruby
order = KondutoOrder.new
order.id = "123"
order.total_amount = 123.4
order.customer = customer
```

>
**NOTICE**: the order created above is really, really simple. The more detail you provide, more accurate Konduto's analysis will be.
>

### Order parameters

| Parameter          | Description                                                                                                                                                                                      |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| id                 | (required) Unique identifier for each order.Max. 100 chars, alpha-numeric.                                                                                                                       |
| visitor            | (optional) Visitor identifier obtained from our JavaScript.Max. 40 chars, alpha-numeric.                                                                                                         |
| total_amount       | (required) Total order amount.Max. 10 chars, number.                                                                                                                                             |
| shipping_amount    | (optional) Shipping amount.Max. 10 chars, number.                                                                                                                                                |
| tax_amount         | (optional) Tax amount.Max. 10 chars, number.                                                                                                                                                     |
| currency           | (optional) 3-letter currency code (ISO-4712).Max. 3 chars, string.                                                                                                                               |
| installments       | (optional) Number of payment installments.Max. 3 chars, number.                                                                                                                                  |
| ip                 | (optional) Client IPv4 address. Ex: IPV4 - 189.68.156.100 Max. 15 chars, string. IPV6 address customer (without abbreviations). Ex: IPV6 - 2001:0DB8:AD1F:25E2:CADE:CAFE:F0CA:84C1 String.       |
| first_message      | (optional) In the Marketplace, it brings the date and time of the first message exchanged between buyer and seller. YYYY-MM-DDTHH:mm:ssZ format (ISO 8601).Max. 20 chars, string.                |
| messages_exchanged | (optional) In the Marketplace, it must bring the number of messages exchanged between buyer and seller until the moment of the transaction.Number.                                               |
| purchase_at        | (optional) In the Marketplace, it brings the date and time of the order closing on the website. YYYY-MM-DDTHH:mm:ssZ format (ISO 8601)Exactly 20 chars, string.                                  |
| analyze            | (optional) If false the system will take the transaction into account in the next reviews but does not return a recommendation and you are not charged.Boolean. If not sent the default is true. |
| customer           | (required) Object containing customer details.                                                                                                                                                   |
| payment            | (optional) List containing payment methods.                                                                                                                                                      |
| billing            | (optional) Object containing the billing address.                                                                                                                                                |
| shipping           | (optional) Object containing the delivery address.                                                                                                                                               |
| shopping_cart      | (optional) List containing the purchased items.                                                                                                                                                  |
| hotel              | (optional) Object containing hotel and guest data.                                                                                                                                               |
| travel             | (optional) Object containing travel and passenger data.                                                                                                                                          |
| seller             | (optional) Object intended for the data of the product seller.                                                                                                                                   |
| events             | (optional) List of events promoted by the store.                                                                                                                                                 |

### Customer information

| Parameter   | Description                                                                                                                                                     |
| ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| id          | (required) Unique customer identifier. It can be any value (sequential, document, email) as long as it is consistent with future orders.Max. 100 chars, string. |
| name        | (required) Customer's full name.Max. 100 chars, string.                                                                                                         |
| email       | (required) Customer’s e-mail address.Max. 100 chars, string.                                                                                                    |
| dob         | (optional) Customer's date of birth in YYYY-MM-DD format (ISO 8601).Max. 10 chars, string.                                                                      |
| tax_id      | (optional) Customer’s tax document number (CPF, CNPJ, etc).Max. 100 chars, string.                                                                              |
| phone1      | (optional) Primary customer’s phone number.Max. 100 chars, string.                                                                                              |
| phone2      | (optional) Secondary customer’s phone number.Max. 100 chars, string.                                                                                            |
| created_at  | (optional) Date of customer’s account creation or registration on the website, in YYYY-MM-DD format (ISO 8601).Max 10 chars, string.                            |
| new         | (optional) Flag indicating whether the customer is using a newly created account on this purchase.Boolean.                                                      |
| vip         | (optional) Flag indicating whether this is a VIP customer or a frequent buyer.Boolean.                                                                          |
| type        | (optional) Customer type identifier.String.                                                                                                                     |
| risk_level  | (optional) Risk level identifier. We currently use low, medium, high.String.                                                                                    |
| risk_score  | (optional) Customer risk score identifier.Number.                                                                                                               |
| mother_name | (optional) Full name of the client's mother.Max. 100 chars, string                                                                                              |

### Payment information

| Parameter       | Description                                                                                                                                                                                                                                                                |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| type            | (required) Payment method used by the customer. We currently support `credit`, `boleto`, `debit`, `transfer `and `voucher`.Max. 8 chars, string.                                                                                                                           |
| status          | (required) The payment status returned by the card operator. It can be `approved` (approved), `declined` (declined) or `pending`(pending), if payment has not yet been made.Max. 8 chars, string.This field should only be sent for the payment type `payment.type=credit` |
| bin             | (optional) The first six credit card numbers are used to identify the type of card used.Max. 6 chars, string.This field should only be sent for the payment type `payment.type=credit`                                                                                     |
| last4           | (optional) The last four digits of the credit card.Max. 4 chars, string.This field should only be sent for the payment type `payment.type=credit`                                                                                                                          |
| amount          | (required) Total order amount.Max. 10 chars, number.                                                                                                                                                                                                                       |
| expiration_date | (optional) Card’s expiration date in MMYYYY format.Max. 6 chars, string.This field should only be sent for the payment type `payment.type=credit`                                                                                                                          |
| description     | (optional) Some information regarding the discount..Max. 100 chars, string.                                                                                                                                                                                                |

### Billing address

| Parameter | Description                                                                 |
| --------- | --------------------------------------------------------------------------- |
| name      | (optional) Cardholder’s name.Max. 100 chars, string.                        |
| address1  | (optional) Customer’s invoice address with the bank.Max. 255 chars, string. |
| address2  | (optional) Complement of the invoice address.Max. 255 chars, string.        |
| city      | (optional) Cardholder’s city.Max. 100 chars, string.                        |
| state     | (optional) Cardholder’s stateMax. 100 chars, string.                        |
| zip       | (optional) Cardholder’s Zip Code.Max. 100 chars, string.                    |
| country   | (optional) Cardholder’s country code. (ISO 3166-2).Max. 2 chars, string.    |


### Shipping address

| Parameter | Description                                                                 |
| --------- | --------------------------------------------------------------------------- |
| name      | (optional) Cardholder’s name.Max. 100 chars, string.                        |
| address1  | (optional) Customer’s invoice address with the bank.Max. 255 chars, string. |
| address2  | (optional) Complement of the invoice address.Max. 255 chars, string.        |
| city      | (optional) Customer’s city.Max. 100 chars, string.                          |
| state     | (optional) Customer’s status.Max. 100 chars, string.                        |
| zip       | (optional) Customer’s zip code.Max. 100 chars, string.                      |
| country   | (optional) Customer’s country code. (ISO 3166-2) .Max. 2 chars, string.     |

### Delivery

| Parameter               | Description                                                                                                                              |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| delivery_company        | (recommended) Adds the name of the company that will deliver the product to the customer. Example: `GFL` String, up to 100 chars.        |
| delivery_method         | (recommended) Details the type of withdrawal type, if applicable. Example: `retire_loja` String, up to 100 chars.                        |
| estimated_shipping_date | (recommended) Informs the estimated delivery date of the product. Example: `2021-05-06` String, format YYYY-MM-DDThh:mmZ (ISO 8601)      |
| estimated_delivery_date | (recommended) Informs the estimated date of withdrawal of the product. Example: `2021-05-06` String, format YYYY-MM-DDThh:mmZ (ISO 8601) |

### External device

| Parameter    | Description                                                             |
| ------------ | ----------------------------------------------------------------------- |
| fingerprint  | (required) Browser identification. Max. 255 e min. 3, string            |
| provider     | (recommended) Provider type. Max. 225 e min. 2 chars, string.           |
| category     | (recommended) Category type. Max. 225 e min. 2 chars, string.           |
| model        | (recommended) Type of model used. Max. 225 chars, string.               |
| platform     | (recommended) Device type by customer. Max. 225 e min. 2 chars, string. |
| manufacturer | (recommended) Which Manufacturer. Max. 225 e min. 2 chars, string.      |
| os           | (recommended) What Operating System. Max. 225 e min. 2 chars, string.   |
| browser      | (recommended) Which browser. Max. 225 e min. 2 chars, string.           |
| language     | (recommended) Language used. Max 255, string.                           |

### Shopping cart

| Parameter               | Description                                                                                                                                                                                              |
| ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| sku                     | (recommended) SKU or inventory number of the product or service. Max. 100 chars, string.                                                                                                                 |
| product_code            | (recommended) Barcode or UPC product or service. Max. 100 chars, string.                                                                                                                                 |
| category                | (recommended) Category code of the product purchased. See our [list of categories](https://docs.konduto.com/reference/categorias-de-produtos-e-c%C3%B3digos) for more information. Max. 4 chars, number. |
| name                    | (recommended) Product or service name. Max. 100 chars, string.                                                                                                                                           |
| description             | (recommended) Detailed description of the product or service. Max. 100 chars, string.                                                                                                                    |
| unit_cost               | (recommended) Unit cost of this product or service. Max. 10 chars, number.                                                                                                                               |
| quantity                | (recommended) Number of units purchased. Max. 10 chars, number.                                                                                                                                          |
| discount                | (recommended) Product discount value. Max. 10 chars, number.                                                                                                                                             |
| created_at              | (recommended) Date of publication of the product on the website, in YYYY-MM-DD format. (ISO 8601). Max. 10 chars, string.                                                                                |
| delivery_type           | (optional) Delivery type. Max. 255 chars, string.                                                                                                                                                        |
| delivery_sla_in_minutes | (optional) Estimated delivery time in minutes. Min. 0 and max. 9999999999. Number.                                                                                                                       |
| seller_id               | (optional) Seller identifier. Max. 255 chars, string.                                                                                                                                                    |


### Travel

| Parameters      | Description                                              |
| --------------- | -------------------------------------------------------- |
| type            | (required) Type of trip. Currently `flight` or `bus`.    |
| expiration_date | (recommended) Expiration date. Datetime.                 |
| departure       | (required) Object with departure information.            |
| return          | (recommended) Object with the return travel information. |
| passengers      | (required) Array of objects with passengers’ data.       |

#### Departure/return

| Parameter             | Description                                                                                                |
| --------------------- | ---------------------------------------------------------------------------------------------------------- |
| origin_city           | (required if type=bus) City of origin. Max 100 chars, string.                                              |
| destination_city      | (required if type=bus) Destination city. Max 100 chars, string.                                            |
| origin_airport        | (required if type=flight) IATA airport code to the airport of origin. Exactly 3 chars, string.             |
| destination_airport   | (required if type=flight) IATA airport code to the airport of destiny. Exactly 3 chars, string.            |
| date                  | (required) Date and time of boarding in UTC in YYYY-MM-DDThh:mmZ format (ISO 8601). Max. 17 chars, string. |
| number_of_connections | (recommended) Number of connections .Integer.                                                              |
| class                 | (recommended) Class name, such as `economy`, `business` and `first`. Max. 8 chars, string.                 |
| fare_basis            | (recommended) Class code. Max 20 chars, string.                                                            |
| company               | (recommended) Name of the airline company. Max. 255 chars, string.                                         |

#### Passenger

| Parameter         | Description                                                                                     |
| ----------------- | ----------------------------------------------------------------------------------------------- |
| name              | (required) Passenger's full name. Max 100 chars, string.                                        |
| document          | (required) Document number. Max 100 chars, string.                                              |
| document_type     | (required) Document type. Can be `passport` or `id`. Max 8 chars, string.                       |
| dob               | (recommended) Passenger's date of birth in YYYY-MM-DD format (ISO 8601). Max. 10 chars, string. |
| nationality       | (recommended) Passenger's country of birth (ISO 3166-2). Max. 2 chars, string.                  |
| loyalty           | (optional) Passenger's loyalty program.                                                         |
| frequent_traveler | (recommended) Flag of frequent traveler. Boolean, default is `false`.                           |
| special_needs     | (recommended) Flag of frequent traveler. Boolean, default is `false`.                           |

#### Loyalty

| Parameter | Description                                                            |
| --------- | ---------------------------------------------------------------------- |
| program   | Loyalty program type. Max. 255 chars, String Ex.: `smiles`             |
| category  | Loyalty program category. Max. 255 chars, String Ex.: `gold`, `silver` |


### Hotel

| Parameter | Description                                                                     |
| --------- | ------------------------------------------------------------------------------- |
| name      | (required) Name of the hotel.Max. 100 chars, string.                            |
| address1  | (optional) Hotel’s address.Max. 255 chars, string.                              |
| address2  | (optional) Complement of the hotel’s address.Max. 255 chars, string.            |
| city      | (optional) Hotel’s city.Max. 100 chars, string.                                 |
| state     | (optional) Acronym for the hotel’ state.Max. 100 chars, string.                 |
| zip       | (optional) Hotel’s zip code.Max. 100 chars, string.                             |
| country   | (optional) Hotel’s country.Max. 2 chars, string.                                |
| category  | (optional) Hotel’s category.Max. 100 chars, string.                             |
| rooms     | (required) Object with information about the hotel’s roomsMax. 20 itens, array. |

#### Room

| Parameter        | Description                                                                                                    |
| ---------------- | -------------------------------------------------------------------------------------------------------------- |
| number           | (optional) Room’s number.Max. 100 chars, string.                                                               |
| code             | (optional) Room’s codeMax. 100 chars, string.                                                                  |
| type             | (optional) Room type.Max. 100 chars, string.                                                                   |
| check_in_date    | (required) Date and time of check-in in UTC in the YYYY-MM-DDThh:mmZ format (ISO 8601) .Max. 17 chars, string. |
| check_out_date   | (optional) Date and time of check-out in UTC in the YYYY-MM-DDThh:mmZ (ISO 8601) .Max. 17 chars, string.       |
| number_of_guests | (optional) Number of people.Max. 9999 chars, number.                                                           |
| board_basis      | (optional) Feeding regime.Max. 100 chars, string.                                                              |
| guests           | (required) Room guests.Max. 20 items, array.                                                                   |

#### Guest

| Parameter     | Description                                                                                                      |
| ------------- | ---------------------------------------------------------------------------------------------------------------- |
| name          | (required) Guest’s name.Max. 100 chars, string.                                                                  |
| document      | (optional) Guest's document number.Max. 8 chars, string.                                                         |
| document_type | (optional) Document used by the customer. We currently support `cpf`, `rg`, `passport`, `id` and `other`.string. |
| dob           | (optional) Customer's date of birth in YYYY-MM-DD format (ISO 8601).Max 10 chars, string.                        |
| nationality   | (optional) Guest’s nationality.Max. 2 chars, string.                                                             |


### Event

| Parameter | Description                                                                                                                                    |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| name      | (required) Name of the event.Max. 255 chars, string.                                                                                           |
| date      | (required) Date and time of the event in UTC in the YYYY-MM-DDThh:mmZ format (ISO 8601) Max. 17 chars, datetime, string.                       |
| type      | (required) Type of the event. We currently support `show`, `theater`, `movies`, `party`, `festival`, `course`, `sports` and `corporate`string. |
| subtype   | (optional) Detail of the event type.Max. 255 chars, string.                                                                                    |
| venue     | (optional) Object with the location information of the event.                                                                                  |
| tickets   | (optional) Array of objects with ticket data.                                                                                                  |

#### Venue

| Parameter | Description                                                           |
| --------- | --------------------------------------------------------------------- |
| name      | (optional) Place’s nameMax. 255 chars, string.                        |
| address   | (optional) Place’s addressMax. 255 chars, string.                     |
| city      | (optional) Place’s cityMax. 255 chars, string.                        |
| state     | (optional) Place’s stateMax. 100, string.                             |
| country   | (optional) Place’s country pursuant to ISO 3166-2Max. 2 chars, string |
| capacity  | (optional) Place’s capacityinteger.                                   |

#### Ticket

| Parameter | Note                                                                                                 |
| --------- | ---------------------------------------------------------------------------------------------------- |
| id        | (optional) Unique ticket identifier.Max. 255 chars, string.                                          |
| category  | (required) Unique ticket identifier.`student`, `senior`, `government`, `social` and `regular`.string |
| section   | (optional) Unique ticket identifier.Max. 255 chars, string.                                          |
| premium   | (required) Premium ticket indicator, receive only `true` or `false`.boolean                          |
| attendee  | (required) Array of objects with participant data.                                                   |

#### Attendee

| Parameter     | Note                                                                                                                    |
| ------------- | ----------------------------------------------------------------------------------------------------------------------- |
| name          | (optional) are described in the table below as well:Max. 255 chars, string.                                             |
| document      | (required) Participant's document.Max. 100 chars, string.                                                               |
| document_type | (optional) Type of document of the participant. We currently support `cpf`, `cnpj`, `rg`, `passport` and `other`.string |
| dob           | (optional) Date of birth of the participant in UTC in the YYYY-MM-DD format (ISO 8601) .Max. 17 chars, string.          |

### Vehicle

| Parâmetro    | Descrição                                                                                                                                                                 |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| vid          | (optional) Unique vehicle identifier.Max. Min. 17 chars, string                                                                                                           |
| renavam      | (optional) Renavan identification of the vehicle.Max. 11 chars, string                                                                                                    |
| registration | (optional) Vehicle licence.Max. 15 chars, string                                                                                                                          |
| make         | (required) Vehicle brand.Max. 63 chars, string                                                                                                                            |
| model        | (required) Vehicle model.Max. 100 chars, string                                                                                                                           |
| owner        | (required) Array for vehicle owner information.                                                                                                                           |
| type         | (optional) Describes the type of vehicle, for example: `car`, `bus`, `truck`, `motorcycle`, `aircraft`, `boat`, `bicycle`.Max. 15 chars, string                           |
| usage        | (optional) Describes the use of the vehicle in the operation. Accepts values like:`private`, `commercial`, `experimental`, `government`, `military`, `instruction`.String |

##### Owner

| Parâmetro | Descrição                                                |
| --------- | -------------------------------------------------------- |
| name      | (optional) Vehicle owner's name.Max 255 chars, string.   |
| tax_id    | (required) Vehicle owner document.Max 100 chars, string. |

### Seller

| Parameter  | Description                                                                                                         |
| ---------- | ------------------------------------------------------------------------------------------------------------------- |
| id         | (required)  Unique identifier of the seller within the Marketplace..Max. 100 chars, string.                         |
| name       | (optional) Store or seller’s name.Max. 100 chars, string.                                                           |
| created_at | (optional) Date of creation of the store in the Marketplace, in YYYY-MM-DD format (ISO 8601).Max. 10 chars, string. |

### Point of sale

| Parameter | Description                                                                                                       |
| --------- | ----------------------------------------------------------------------------------------------------------------- |
| id        | (required) Unique identifier of the physical store.Max. 100 chars, string.                                        |
| name      | (required) Full name of the physical store.Max. 100 chars, string.                                                |
| lat       | (optional) Latitude of the physical store. We currently use maximum: -90, maximum: 90Max. 10 characters, number.  |
| long      | (optional) Length of the physical store. We currently use maximum: -180, maximum: 180.Max. 10 characters, number. |
| address   | (optional) Physical store address.Max. 255 chars, string.                                                         |
| city      | (optional)  Physical store city.Max. 100 chars, string.                                                           |
| state     | (optional)  State of the physical store.Max. 100 chars, string.                                                   |
| zip       | (optional)  Physical store zip code.Max. 100 chars, string.                                                       |
| country   | (optional) Country code of holder (ISO 3166-2) .Max. 2 chars, string.                                             |

### Agent

| Parameter  | Description                                                                                                                                    |
| ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| id         | (mandatory) Seller's unique identifier.Max. 100 chars, string.                                                                                 |
| login      | (optional) Seller login.Max. 100 chars, string.                                                                                                |
| name       | (mandatory) Seller's full name.Max. 100 chars, string.                                                                                         |
| tax_id     | (optional) Seller's tax document number (CPF, etc).Max. 100 chars, string.                                                                     |
| dob        | (optional) Seller's date of birth in YYYY-MM-DD format (ISO 8601).Max. 10 chars, string.                                                       |
| category   | (optional) Category code of the product sold.Max. 100 chars, string.                                                                           |
| created_at | (optional) Date of creation of the account or registration of the seller on the website, in YYYY-MM-DD format (ISO 8601).Max 10 chars, string. |


### Origin account

| Parameter     | Description                                                                                                                                           |
| ------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| id            | (optional) Unique account identifier.Max. 255 chars, string.                                                                                          |
| key_type      | (optional) Type of key used to identify the account. We currently support `pix_cpf`, `pix_cnpj`, `pix_phone`, `pix_email`, `pix_evp`, `p2p` e `none`. |
| key_value     | (optional) Key value used to identify the account.Max. 255 chars, string.                                                                             |
| holder_name   | (optional) Name of the account holder.Max. 255 chars, string.                                                                                         |
| holder_tax_id | (optional) CPF/CNPJ of the account holder.Max. 255 chars, string.                                                                                     |
| bank_code     | (optional) Code of the bank to which the account is linked.Max. 255 chars, string.                                                                    |
| bank_name     | (optional) Name of the bank to which the account is linked.Max. 255 chars, string.                                                                    |
| bank_branch   | (optional) Branch of the bank to which the account is linked.Max. 255 chars, string.                                                                  |
| bank_account  | (optional) Account number.Max. 255 chars, string.                                                                                                     |
| balance       | (optional) Current account balance.Max. 10 chars, number.                                                                                             |

### Destination account

| Parameter     | Description                                                                                                                                          |
| ------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| id            | (optional) Unique account identifier.Max. 255 chars, string.                                                                                         |
| key_type      | (optional) Type of key used to identify the account. We currently support `pix_cpf`, `pix_cnpj`, `pix_phone`, `pix_email`, `pix_evp`, `p2p` e `none` |
| key_value     | (optional) Key value used to identify the account.Max. 255 chars, string.                                                                            |
| holder_name   | (optional) Name of the account holder.Max. 255 chars, string.                                                                                        |
| holder_tax_id | (optional) CPF/CNPJ of the account holder.Max. 255 chars, string.                                                                                    |
| bank_code     | (optional) Code of the bank to which the account is linked.Max. 255 chars, string.                                                                   |
| bank_name     | (optional) Name of the bank to which the account is linked.Max. 255 chars, string.                                                                   |
| bank_account  | (optional) Account number.Max. 255 chars, string.                                                                                                    |
| amount        | (optional) Amount sent to the account.Max. 10 chars, number.                                                                                         |


## Sending an order for analysis.

After creating the order, sending it to Konduto's analysis is very simple.

```ruby
if order.valid?
  begin
    konduto.analyze(order);
    # A RuntimeError will be thrown if the response is anything other than 200 OK.
  rescue RuntimeError => e
    # Put any exception handling here.
    p e.message
  end
else
  p order.errors.messages
end
```

Notice that if the analysis fails, a **RuntimError** will be thrown. Handle it as you wish.

After the analysis, some order attributes will be filled. For example the recommendation.

```ruby
# The command below should print something like "Konduto recommendation is to APPROVE".
p "Konduto recommendation is to: #{order.recommendation}";
```

## Querying an order from our servers.

In order to do that use the Konduto class in the following way:

```ruby
order = konduto.get_order order_id # orderId is a String
```

## Updating an order status

```ruby
# the order status will be set to newStatus if the request succeeds.
konduto.update_order_status(order, new_status, 'some comments');
```

| Parameter | Description                                                                                                                             |
| --------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| status    | _(required)_ New status for this transaction. Either `approved`, `declined` or `fraud`, when you have identified a fraud or chargeback. |
| comments  | _(required)_ Reason or comments about the status update.                                                                                |

## Sending requests through a proxy
To send requests through a proxy just build a new Konduto instance and set the proxy host passing the proxy url as parameters of `proxy=` method. If the proxy requires username and password, just set then at the proxy url you'll pass to `proxy=` method.

```ruby
konduto = KondutoRuby.new(API_KEY)
konduto.proxy = 'http://server-ip:port/'
# Or, using username and password
konduto.proxy = 'http://USERNAME:PASSWORD@proxy-server:port/'
# use Konduto's API as usual
konduto.get_order(ORDER_ID)
```

## Reference Tables

Please [click here](http://docs.konduto.com/#n-tables) for the Currency and Category reference tables.

## Troubleshooting

If you experience problems sending orders for analysis, querying orders or updating order status, it might be a good idea
to call `konduto.debug()`. This will print out the API Key, the endpoint, ~~the request body and the response body~~.

## Support

Feel free to end us a feedback via email or open an issue if you have some doubts or find out bugs. You can also contact konduto's [support team](mailto:support@konduto.com) if you have any questions or suggestions!
