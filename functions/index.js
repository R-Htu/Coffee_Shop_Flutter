const { onRequest } = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
/*const stripe = require("stripe")("secrey key need to be added here");

exports.stripePaymentIntentRequest = onRequest(async (req, res) => {
    try {
        const { email, amount } = req.body;

        if (!email || !amount) {
            return res.status(400).send({ success: false, error: 'Email and amount are required' });
        }

        // Validate amount (must be a positive number)
        const parsedAmount = parseInt(amount);
        if (isNaN(parsedAmount) || parsedAmount <= 0) {
            return res.status(400).send({ success: false, error: 'Invalid amount' });
        }

        let customerId;

        // Fetch customer by email
        const customerList = await stripe.customers.list({
            email,
            limit: 1
        });

        // If customer exists, use their ID, else create a new customer
        if (customerList.data.length !== 0) {
            customerId = customerList.data[0].id;
        } else {
            const customer = await stripe.customers.create({ email });
            customerId = customer.id;
        }

        // Create an ephemeral key for the customer
        const ephemeralKey = await stripe.ephemeralKeys.create(
            { customer: customerId },
            { apiVersion: '2020-08-27' }  // Use latest API version if possible
        );

        // Create the payment intent
        const paymentIntent = await stripe.paymentIntents.create({
            amount: parsedAmount,
            currency: 'sgd',
            customer: customerId,
        });

        // Send response with the payment intent details
        res.status(200).send({
            paymentIntent: paymentIntent.client_secret,
            ephemeralKey: ephemeralKey.secret,
            customer: customerId,
            success: true,
        });
    } catch (error) {
        // Log the error for debugging purposes
        logger.error('Error creating payment intent:', error);

        // Send an appropriate error response
        res.status(500).send({ success: false, error: error.message });
    }
});
*/