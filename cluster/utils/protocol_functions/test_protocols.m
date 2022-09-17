function test_protocols()
    protocols = [
        [100.00, 20, 15];
        [1000.00, 20, 15];
        [10000.00, 20, 15];

        [1000.0, 2000.0, 3000.0, 4000.0, 5000.0, 6000.0, 7000.0, 8000.0, 9000.0, 10000.0, 17.666, 13];
        [500.00,  750.0, 1200.0, 1500.0, 2000.0, 2500.0, 17.666, 13];
        [1000.0, 2500.0, 4000.0, 5500.0, 7000.0, 17.666, 13];
        [1000.0, 3000.0, 5000.0, 10000.0, 17.666, 13];

        [1000.0, 2000.0, 3000.0, 4000.0, 5000.0, 20, 15];
    ];

    for i=size(population,1)
        protocol = protocols(i,:);
        disp(protocol);
    end
end