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

| Parameter               | Description                                                                                                                           |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| delivery_company        | (optional) Adds the name of the company that will deliver the product to the customer. Example: `GFL` String, up to 100 chars.        |
| delivery_method         | (optional) Details the type of withdrawal type, if applicable. Example: `retire_loja` String, up to 100 chars.                        |
| estimated_shipping_date | (optional) Informs the estimated delivery date of the product. Example: `2021-05-06` String, format YYYY-MM-DDThh:mmZ (ISO 8601)      |
| estimated_delivery_date | (optional) Informs the estimated date of withdrawal of the product. Example: `2021-05-06` String, format YYYY-MM-DDThh:mmZ (ISO 8601) |

### External device

| Parameter    | Description                                                        |
| ------------ | ------------------------------------------------------------------ |
| fingerprint  | (optional) Browser identification.Max. 255 e min. 3, string        |
| provider     | (optional) Provider typeMax. 225 e min. 2 chars, string.           |
| category     | (optional) Category typeMax. 225 e min. 2 chars, string.           |
| model        | (optional) Type of model usedMax. 225 chars, string.               |
| platform     | (optional) Device type by customerMax. 225 e min. 2 chars, string. |
| manufacturer | (optional) Which ManufacturerMax. 225 e min. 2 chars, string.      |
| os           | (optional) What Operating SystemMax. 225 e min. 2 chars, string.   |
| browser      | (optional) Which browserMax. 225 e min. 2 chars, string.           |
| language     | (optional) Language usedString                                     |

### Shopping cart

| Parameter    | Description                                                                                                              |
| ------------ | ------------------------------------------------------------------------------------------------------------------------ |
| sku          | (optional) SKU or inventory number of the product or service.Max. 100 chars, string.                                     |
| product_code | (optional) Barcode or UPC product or service.Max. 100 chars, string.                                                     |
| category     | (optional) Category code of the product purchased. See our list of categories for more information.Max. 4 chars, number. |
| name         | (optional) Product or service name.Max. 100 chars, string.                                                               |
| description  | (optional) Detailed description of the product or service.Max. 100 chars, string.                                        |
| unit_cost    | (optional) Unit cost of this product or service.Max. 10 chars, number.                                                   |
| quantity     | (optional) Number of units purchased.Max. 10 chars, number.                                                              |
| discount     | (optional) Product discount value.Max. 10 chars, number.                                                                 |
| created_at   | (optional) Date of publication of the product on the website, in YYYY-MM-DD format. (ISO 8601).Max. 10 chars, string.    |


### Travel

| Parameters      | Description                                           |
| --------------- | ----------------------------------------------------- |
| type            | (required) Type of trip. Currently `flight` or `bus`. |
| expiration_date | (optional) Expiration date.Datetime                   |
| departure       | (required) Object with departure information.         |
| return          | (optional) Object with the return travel information. |
| passengers      | (required) Array of objects with passengers’ data.    |

#### Departure/return

| Parameter             | Description                                                                                               |
| --------------------- | --------------------------------------------------------------------------------------------------------- |
| origin_city           | (required if type=bus) City of origin.Max 100 chars, string.                                              |
| destination_city      | (required if type=bus) Destination city.Max 100 chars, string.                                            |
| origin_airport        | (required if type=flight)IATA airport code to the airport of origin.Exactly 3 chars, string.              |
| destination_airport   | (required if type=flight)IATA airport code to the airport of destiny.Exactly 3 chars, string.             |
| date                  | (required) Date and time of boarding in UTC in YYYY-MM-DDThh:mmZ format (ISO 8601) Max. 17 chars, string. |
| number_of_connections | (optional) Number of connections.Integer.                                                                 |
| class                 | (optional) Class name, such as `economy`, `business` and `first`.Max. 8 chars, string.                    |
| fare_basis            | (optional)  Class code.Max 20 chars, string.                                                              |
| company               | (optional) Name of the airline company.Max. 255 chars, string.                                            |

#### Passenger

| Parameter         | Description                                                                                 |
| ----------------- | ------------------------------------------------------------------------------------------- |
| name              | (required) Passenger's full name.Max 100 chars, string.                                     |
| document          | (required) Document number.Max 100 chars, string.                                           |
| document_type     | (required) Document type. Can be `passport` or `id`.Max 8 chars, string.                    |
| dob               | (optional) Passenger's date of birth in YYYY-MM-DD format (ISO 8601).Max. 10 chars, string. |
| nationality       | (optional) Passenger's country of birth (ISO 3166-2).Max. 2 chars, string.                  |
| frequent_traveler | (optional) Flag of frequent traveler..Boolean, default is `false`.                          |
| special_needs     | (optional) Flag of frequent traveler.Boolean, default is `false`.                           |

#### Loyalty

| Parameter | Description                                                           |
| --------- | --------------------------------------------------------------------- |
| program   | Loyalty program type.Max. 255 chars, String Ex.: `smiles`             |
| category  | Loyalty program category.Max. 255 chars, String Ex.: `gold`, `silver` |


### Hotel

| Parameter | Description                                                                       |
| --------- | --------------------------------------------------------------------------------- |
| name      | (required) Name of the hotel. Max. 100 chars, string.                             |
| address1  | (recommended) Hotel’s address. Max. 255 chars, string.                            |
| address2  | (recommended) Complement of the hotel’s address. Max. 255 chars, string.          |
| city      | (recommended) Hotel’s city. Max. 100 chars, string.                               |
| state     | (recommended) Acronym for the hotel’ state. Max. 100 chars, string.               |
| zip       | (recommended) Hotel’s zip code. Max. 100 chars, string.                           |
| country   | (recommended) Hotel’s country. Max. 2 chars, string.                              |
| category  | (recommended) Hotel’s category. Max. 100 chars, string.                           |
| rooms     | (required) Object with information about the hotel’s rooms. Max. 20 items, array. |

#### Room

| Parameter        | Description                                                                                                    |
| ---------------- | -------------------------------------------------------------------------------------------------------------- |
| number           | (recommended) Room’s number. Max. 100 chars, string.                                                           |
| code             | (recommended) Room’s code. Max. 100 chars, string.                                                             |
| type             | (recommended) Room type. Max. 100 chars, string.                                                               |
| check_in_date    | (required) Date and time of check-in in UTC in the YYYY-MM-DDThh:mmZ format (ISO 8601). Max. 17 chars, string. |
| check_out_date   | (recommended) Date and time of check-out in UTC in the YYYY-MM-DDThh:mmZ (ISO 8601). Max. 17 chars, string.    |
| number_of_guests | (recommended) Number of people. Max. 9999, number.                                                             |
| board_basis      | (recommended) Feeding regime. Max. 100 chars, string.                                                          |
| guests           | (required) Room guests. Max. 20 items, array.                                                                  |

#### Guest

| Parameter     | Description                                                                                                          |
| ------------- | -------------------------------------------------------------------------------------------------------------------- |
| name          | (required) Guest’s name. Max. 100 chars, string.                                                                     |
| document      | (recommended) Guest's document number. Max. 8 chars, string.                                                         |
| document_type | (recommended) Document used by the customer. We currently support `cpf`, `rg`, `passport`, `id` and `other`. string. |
| dob           | (recommended) Customer's date of birth in YYYY-MM-DD format (ISO 8601). Max 10 chars, string.                        |
| nationality   | (recommended) Guest’s nationality. Max. 2 chars, string.                                                             |


### Event

| Parameter | Description                                                                                                                                      |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| name      | (required) Name of the event. Max. 255 chars, string.                                                                                            |
| date      | (required) Date and time of the event in UTC in the YYYY-MM-DDThh:mmZ format (ISO 8601). Max. 17 chars, datetime, string.                        |
| type      | (required) Type of the event. We currently support `show`, `theater`, `movies`, `party`, `festival`, `course`, `sports` and `corporate`. string. |
| subtype   | (recommended ) Detail of the event type. Max. 255 chars, string.                                                                                 |
| venue     | (recommended ) Object with the location information of the event.                                                                                |
| tickets   | (recommended ) Array of objects with ticket data.                                                                                                |

#### Venue

| Parameter | Description                                                                |
| --------- | -------------------------------------------------------------------------- |
| name      | (recommended) Place’s name. Max. 255 chars, string.                        |
| address   | (recommended) Place’s address. Max. 255 chars, string.                     |
| city      | (recommended) Place’s city. Max. 255 chars, string.                        |
| state     | (recommended) Place’s state. Max. 100, string.                             |
| country   | (recommended) Place’s country pursuant to ISO 3166-2. Max. 2 chars, string |
| capacity  | (recommended) Place’s capacity. integer.                                   |

#### Ticket

| Parameter | Note                                                                                                                        |
| --------- | --------------------------------------------------------------------------------------------------------------------------- |
| id        | (recommended) Unique ticket identifier. Max. 255 chars, string.                                                             |
| category  | (required) Ticket category. Actually supported values are `student`, `senior`, `government`, `social` and `regular`. string |
| section   | (recommended) Ticket section. Max. 255 chars, string.                                                                       |
| premium   | (required) Indicates if the ticket is premium, receive only `true` or `false`. boolean.                                     |
| attendee  | (required) Array of objects with attendee data.                                                                             |

#### Attendee

| Parameter     | Note                                                                                                              |
| ------------- | ----------------------------------------------------------------------------------------------------------------- |
| name          | (recommended) Attendee's name. Max. 255 chars, string.                                                            |
| document      | (required) Attendee's document. Max. 100 chars, string.                                                           |
| document_type | (recommended) Attendee's document type. We currently support `cpf`, `cnpj`, `rg`, `passport` and `other`. string. |
| dob           | (recommended) Attendee's date of birth in UTC in the YYYY-MM-DD format (ISO 8601). Max. 17 chars, string.         |

### Vehicle

| Parâmetro    | Descrição                                                                                                                                  |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------ |
| vid          | (recommended) Vehicle's unique identifier. Max. Min. 17 chars, string.                                                                     |
| renavam      | (recommended) Renavan identification of the vehicle. Max. 11 chars, string.                                                                |
| registration | (recommended) Vehicle licence. Max. 15 chars, string.                                                                                      |
| make         | (required) Vehicle brand. Max. 63 chars, string.                                                                                           |
| model        | (required) Vehicle model. Max. 100 chars, string.                                                                                          |
| owner        | (required) Array for vehicle owners information.                                                                                           |
| type         | (recommended) Vehicle type. Valid options are: `car`, `bus`, `truck`, `motorcycle`, `aircraft`, `boat`, `bicycle`. Max. 15 chars, string.  |
| usage        | (recommended) Vehicle usage. Accepts values like: `private`, `commercial`, `experimental`, `government`, `military`, `instruction`. String |

##### Owner

| Parâmetro | Descrição                                                   |
| --------- | ----------------------------------------------------------- |
| name      | (recommended) Vehicle owner's name. Max 255 chars, string.  |
| tax_id    | (required) Vehicle owner's document. Max 100 chars, string. |

### Seller

| Parameter  | Description                                                                                                             |
| ---------- | ----------------------------------------------------------------------------------------------------------------------- |
| id         | (required)  Unique identifier of the seller within the Marketplace. Max. 100 chars, string.                             |
| name       | (recommended) Store or seller’s name. Max. 100 chars, string.                                                           |
| created_at | (recommended) Date of creation of the store in the Marketplace, in YYYY-MM-DD format (ISO 8601). Max. 10 chars, string. |

### Point of sale

| Parameter | Description                                                                                                              |
| --------- | ------------------------------------------------------------------------------------------------------------------------ |
| id        | (required) Unique identifier of the physical store. Max. 100 chars, string.                                              |
| name      | (required) Full name of the physical store. Max. 100 chars, string.                                                      |
| lat       | (recommended) Latitude of the physical store. We currently use maximum: -90, maximum: 90. Max. 10 characters, number.    |
| long      | (recommended) Longitude of the physical store. We currently use maximum: -180, maximum: 180. Max. 10 characters, number. |
| address   | (recommended) Physical store's address. Max. 255 chars, string.                                                          |
| city      | (recommended) Physical store's city. Max. 100 chars, string.                                                             |
| state     | (recommended) Physical store's state. Max. 100 chars, string.                                                            |
| zip       | (recommended) Physical store's zip code. Max. 100 chars, string.                                                         |
| country   | (recommended) Country code of store's holder (ISO 3166-2). Max. 2 chars, string.                                         |

### Agent

| Parameter  | Description                                                                                                                                        |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| id         | (required) Seller's unique identifier. Max. 100 chars, string.                                                                                     |
| login      | (recommended) Seller's login. Max. 100 chars, string.                                                                                              |
| name       | (required) Seller's full name. Max. 100 chars, string.                                                                                             |
| tax_id     | (recommended) Seller's tax document number (CPF, etc). Max. 100 chars, string.                                                                     |
| dob        | (recommended) Seller's date of birth in YYYY-MM-DD format (ISO 8601). Max. 10 chars, string.                                                       |
| category   | (recommended) Category code of the product sold. Max. 100 chars, string.                                                                           |
| created_at | (recommended) Date of creation of the account or registration of the seller on the website, in YYYY-MM-DD format (ISO 8601). Max 10 chars, string. |


### Origin account

| Parameter     | Description                                                                                                                                                |
| ------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| id            | (recommended) Account's unique identifier. Max. 255 chars, string.                                                                                         |
| key_type      | (recommended) Type of key used to identify the account. We currently support `pix_cpf`, `pix_cnpj`, `pix_phone`, `pix_email`, `pix_evp`, `p2p` and `none`. |
| key_value     | (recommended) Key used to identify the account. Max. 255 chars, string.                                                                                    |
| holder_name   | (recommended) Name of the account holder. Max. 255 chars, string.                                                                                          |
| holder_tax_id | (recommended) CPF/CNPJ of the account holder. Max. 255 chars, string.                                                                                      |
| bank_code     | (recommended) Code of the bank to which the account is linked. Max. 255 chars, string.                                                                     |
| bank_name     | (recommended) Name of the bank to which the account is linked. Max. 255 chars, string.                                                                     |
| bank_branch   | (recommended) Bank branch to which the account is linked. Max. 255 chars, string.                                                                          |
| bank_account  | (recommended) Account number. Max. 255 chars, string.                                                                                                      |
| balance       | (recommended) Current account balance. Number.                                                                                                             |

### Destination account

| Parameter     | Description                                                                                                                                               |
| ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| id            | (recommended) Account's unique identifier. Max. 255 chars, string.                                                                                        |
| key_type      | (recommended) Type of key used to identify the account. We currently support `pix_cpf`, `pix_cnpj`, `pix_phone`, `pix_email`, `pix_evp`, `p2p` and `none` |
| key_value     | (recommended) Key used to identify the account. Max. 255 chars, string.                                                                                   |
| holder_name   | (recommended) Name of the account holder. Max. 255 chars, string.                                                                                         |
| holder_tax_id | (recommended) CPF/CNPJ of the account holder. Max. 255 chars, string.                                                                                     |
| bank_code     | (recommended) Code of the bank to which the account is linked. Max. 255 chars, string.                                                                    |
| bank_name     | (recommended) Name of the bank to which the account is linked. Max. 255 chars, string.                                                                    |
| bank_account  | (recommended) Account number. Max. 255 chars, string.                                                                                                     |
| amount        | (recommended) Amount sent to the account. Number.                                                                                                         |


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
