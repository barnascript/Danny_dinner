# Danny_dinner


## Introduction

Danny seriously loves Japanese food so in the beginning of 2021, he decides to embark upon a risky venture and opens up a cute little restaurant that sells his 3 favourite foods: sushi, curry and ramen.

Danny’s Diner needs an assistance to help the restaurant stay afloat - the restaurant has captured some very basic data from their few months of operation but have no idea how to use their data to help them run the business.


## Problem Statement

Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

He plans on using these insights to help him decide whether he should expand the existing customer loyalty program - additionally he needs help to generate some basic datasets so his team can easily inspect the data without needing to use SQL.

Danny has provided you with a sample of his overall customer data due to privacy issues - but he hopes that these examples are enough for you to write fully functioning SQL queries to help him answer his questions!

Danny has shared with you 3 key datasets for this case study:

- <span style="color: red; font-family: monospace;">Sales</span>
- <span style="color: red; font-family: monospace;">Menu</span>
- <span style="color: red; font-family: monospace;">Members</span>


## Example Datasets

All datasets exist within the <code>dannys_diner</code> database schema - be sure to include this reference within your SQL scripts as you start exploring the data and answering the case study questions.


## Table 1: sales

The sales table captures all <code>customer_id</code> level purchases with an corresponding <code>order_date</code> and <code>product_id</code> information for when and what menu items were ordered.

<table>
<thead>
  <tr>
    <th>Customer ID</th>
    <th>Order Date</th>
    <th>Product ID</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>A</td>
    <td>2021-01-01</td>
    <td>1</td>
  </tr>
  <tr>
    <td>A</td>
    <td>2021-01-01</td>
    <td>2</td>
  </tr>
  <tr>
    <td>A</td>
    <td>2021-01-07</td>
    <td>2</td>
  </tr>
  <tr>
    <td>A</td>
    <td>2021-01-10</td>
    <td>3</td>
  </tr>
  <tr>
    <td>A</td>
    <td>2021-01-11</td>
    <td>3</td>
  </tr>
  <tr>
    <td>A</td>
    <td>2021-01-11</td>
    <td>3</td>
  </tr>
  <tr>
    <td>B</td>
    <td>2021-01-01</td>
    <td>2</td>
  </tr>
  <tr>
    <td>B</td>
    <td>2021-01-02</td>
    <td>2</td>
  </tr>
  <tr>
    <td>B</td>
    <td>2021-01-04</td>
    <td>1</td>
  </tr>
  <tr>
    <td>B</td>
    <td>2021-01-11</td>
    <td>1</td>
  </tr>
  <tr>
    <td>B</td>
    <td>2021-01-16</td>
    <td>3</td>
  </tr>
  <tr>
    <td>B</td>
    <td>2021-02-01</td>
    <td>3</td>
  </tr>
  <tr>
    <td>C</td>
    <td>2021-01-01</td>
    <td>3</td>
  </tr>
  <tr>
    <td>C</td>
    <td>2021-01-01</td>
    <td>3</td>
  </tr>
  <tr>
    <td>C</td>
    <td>2021-01-07</td>
    <td>3</td>
  </tr>
</tbody>
</table>

## Table 2: menu

The menu table maps the <code>product_id </code> to the actual <code>product_name</code> and <code>price</code> of each menu item.

<table>
    <thead>
      <tr>
        <th>Product ID</th>
        <th>Product Name</th>
        <th>Price</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>Sushi</td>
        <td>10</td>
      </tr>
      <tr>
        <td>2</td>
        <td>Curry</td>
        <td>15</td>
      </tr>
      <tr>
        <td>3</td>
        <td>Ramen</td>
        <td>12</td>
      </tr>
    </tbody>
  </table>


## Table 3: members

The final members table captures the <code>join_date</code> when a <code>customer_id</code> joined the beta version of the Danny’s Diner loyalty program.


  <table>
    <thead>
      <tr>
        <th>Customer ID</th>
        <th>Join Date</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>A</td>
        <td>2021-01-07</td>
      </tr>
      <tr>
        <td>B</td>
        <td>2021-01-09</td>
      </tr>
      <!-- Add more rows as needed -->
    </tbody>
  </table>

  ## Approach Used

1. Build a database
2. Create table and insert the data.

### Feature Engineering: This will help use generate some new columns from existing ones.

3. Add a new column named combined_table to give insight of sales, members and menu. 

### Exploratory Data Analysis (EDA): Exploratory data analysis is done to answer the listed questions and aims of this project.

## Case Study Questions

Each of the following case study questions can be answered using a single SQL statement:

  <ol>
    <li>What is the total amount each customer spent at the restaurant?</li>
    <li>How many days has each customer visited the restaurant?</li>
    <li>What was the first item from the menu purchased by each customer?</li>
    <li>What is the most purchased item on the menu and how many times was it purchased by all customers?</li>
    <li>Which item was the most popular for each customer?</li>
    <li>Which item was purchased first by the customer after they became a member?</li>
    <li>Which item was purchased just before the customer became a member?</li>
    <li>What is the total items and amount spent for each member before they became a member?</li>
    <li>If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?</li>
    <li>In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B            have at the end of January?</li>
  </ol>



  ``` CREATE SALES TABLE
  DROP TABLE IF EXISTS danny_dinner;
  CREATE TABLE IF NOT EXISTS sales(
  	customer_id varchar(1) not null,
  	order_date date not null,
  	product_id smallint not null
  )
