loan1 = Loan.create(title: "Urban Bees",
                    description: "Buy local Denver honey.",
                    price: 50)

loan2 = Loan.create(title: "Kitten Mittens",
                    description: "Keep your kittens cozy.",
                    price: 25)

loan3 = Loan.create(title: "Bike Bus",
                    description: "We'll bring our shop to you.",
                    price: 100)

category1 = Category.create(name: "Crafts")

category2 = Category.create(name: "Agriculture")

category3 = Category.create(name: "Transportation")

category1.loans << loan2
category2.loans << loan1
category3.loans << loan3
