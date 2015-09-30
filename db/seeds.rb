category1 = Category.create(name: "Crafts")
category2 = Category.create(name: "Agriculture")
category3 = Category.create(name: "Transportation")

Loan.create(title: "Urban Bees",
            description: "Buy local Denver honey.",
            price: 50,
            avatar: open("https://s3-us-west-2.amazonaws.com/turingdenvestments/assets/Fork-Beekeeping.jpg"),
            category: category1)

Loan.create(title: "Kitten Mittens",
            description: "Keep your kittens cozy. These mittens are handcrafted by a Capitol Hill artisan who anticipates being able to repay the loan within 6 months of starting her business. She already has a proven customer base.",
            price: 25,
            avatar: open("https://s3-us-west-2.amazonaws.com/turingdenvestments/assets/3_Kittens_Playing_in_the_Garden.jpg"),
            category: category2)

Loan.create(title: "Bike Bus",
            description: "We'll bring our shop to you.",
            price: 100,
            avatar: open("https://s3-us-west-2.amazonaws.com/turingdenvestments/assets/Hilltop_Bicycles_Summit_NJ.JPG"),
            category: category3)

User.create(username: "alice",
            password: "password",
            full_name: "Alice Jones",
            address: "1500 Blake St., Denver, CO 80205")

User.create(username: "admin",
            password: "password",
            full_name: "Admin Adminerstein",
            address: "123 Admin Blvd, Admintown, AD",
            role: 1)

Order.create(user_id: 1,
             status: "Ordered",
             card_number: "1234123412341234",
             card_expiration: "08/20",
             total_cost: "50.00")

OrderItem.create(loan_id: 1, order_id: 1, quantity: 3)
OrderItem.create(loan_id: 2, order_id: 1, quantity: 1)
OrderItem.create(loan_id: 3, order_id: 1, quantity: 2)
