exports.lambdaHandler = async (event) => {
    console.log('Received event:', JSON.stringify(event, null, 2));
    
    // Extract price from the input event
    const stock_price = event.stock_price || 0;
    
    // Return the price for aggregation
    return {
        stock_price: stock_price
    };
}; 