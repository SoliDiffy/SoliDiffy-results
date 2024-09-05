pragma solidity ^0.5.4;

import "truffle/Assert.sol";
import "../contracts/utils/ModUtils.sol";
import "../contracts/cryptography/AltBn128.sol";

contract TestAltBn128 {

    AltBn128.G1Point public g1 = AltBn128.g1();
    AltBn128.G2Point public g2 = AltBn128.g2();

    function testHashing() public {
        string memory hello = "hello!";
        string memory goodbye = "goodbye.";
        AltBn128.G1Point memory p_1;
        AltBn128.G1Point memory p_2;
        p_1 = AltBn128.g1HashToPoint(bytes(hello));
        p_2 = AltBn128.g1HashToPoint(bytes(goodbye));

        Assert.isNotZero(p_1.x, "X should not equal 0 in a hashed point.");
        Assert.isNotZero(p_1.y, "Y should not equal 0 in a hashed point.");
        Assert.isNotZero(p_2.x, "X should not equal 0 in a hashed point.");
        Assert.isNotZero(p_2.y, "Y should not equal 0 in a hashed point.");

        Assert.isTrue(AltBn128.isG1PointOnCurve(p_1), "Hashed points should be on the curve.");
        Assert.isTrue(AltBn128.isG1PointOnCurve(p_2), "Hashed points should be on the curve.");
    }

    function testHashAndAdd() public {
        string memory hello = "hello!";
        string memory goodbye = "goodbye.";
        AltBn128.G1Point memory p_1;
        AltBn128.G1Point memory p_2;
        p_1 = AltBn128.g1HashToPoint(bytes(hello));
        p_2 = AltBn128.g1HashToPoint(bytes(goodbye));

        AltBn128.G1Point memory p_3;
        AltBn128.G1Point memory p_4;

        p_3 = AltBn128.g1Add(p_1, p_2);
        p_4 = AltBn128.g1Add(p_2, p_1);

        Assert.equal(p_3.x, p_4.x, "Point addition should be commutative.");
        Assert.equal(p_3.y, p_4.y, "Point addition should be commutative.");

        Assert.isTrue(AltBn128.isG1PointOnCurve(p_3), "Added points should be on the curve.");
    }

    function testHashAndScalarMultiply() public {
        string memory hello = "hello!";
        AltBn128.G1Point memory p_1;
        AltBn128.G1Point memory p_2;
        p_1 = AltBn128.g1HashToPoint(bytes(hello));

        p_2 = AltBn128.scalarMultiply(p_1, 12);

        Assert.isTrue(AltBn128.isG1PointOnCurve(p_2), "Multiplied point should be on the curve.");
    }

    uint256[2][] publicundefined;

    uint256[4][] publicundefined;

    function testGfP2Add() public {
        uint i;
        uint8 j;

        AltBn128.gfP2 memory p_1;
        AltBn128.gfP2 memory p_2;
        AltBn128.gfP2 memory p_3;
        AltBn128.gfP2 memory p_4;

        for (i = 0; i < randomG2.length; i++) {
            for (j = 0; j < randomG2.length; j++) {

                p_1 = AltBn128.gfP2Add(AltBn128.gfP2(randomG2[i][0], randomG2[i][1]), AltBn128.gfP2(randomG2[j][0], randomG2[j][1]));
                p_2 = AltBn128.gfP2Add(AltBn128.gfP2(randomG2[i][2], randomG2[i][3]), AltBn128.gfP2(randomG2[j][2], randomG2[j][3]));
                p_3 = AltBn128.gfP2Add(AltBn128.gfP2(randomG2[j][0], randomG2[j][1]), AltBn128.gfP2(randomG2[i][0], randomG2[i][1]));
                p_4 = AltBn128.gfP2Add(AltBn128.gfP2(randomG2[j][2], randomG2[j][3]), AltBn128.gfP2(randomG2[i][2], randomG2[i][3]));

                Assert.equal(p_1.x, p_3.x, "Point addition should be commutative.");
                Assert.equal(p_1.y, p_3.y, "Point addition should be commutative.");
                Assert.equal(p_2.x, p_4.x, "Point addition should be commutative.");
                Assert.equal(p_2.y, p_4.y, "Point addition should be commutative.");

            }
        }
    }

    function testAdd() public {
        uint i;
        uint8 j;

        AltBn128.G1Point memory p_1;
        AltBn128.G1Point memory p_2;

        for (i = 0; i < randomG1.length; i++) {
            for (j = 0; j < randomG1.length; j++) {

                p_1 = AltBn128.g1Add(
                    AltBn128.G1Point(randomG1[i][0], randomG1[i][1]),
                    AltBn128.G1Point(randomG1[j][0], randomG1[j][1])
                );
                p_2 = AltBn128.g1Add(
                    AltBn128.G1Point(randomG1[j][0], randomG1[j][1]),
                    AltBn128.G1Point(randomG1[i][0], randomG1[i][1])
                );

                Assert.equal(p_1.x, p_2.x, "Point addition should be commutative.");
                Assert.equal(p_1.y, p_2.y, "Point addition should be commutative.");

                Assert.isTrue(AltBn128.isG1PointOnCurve(p_1), "Added points should be on the curve.");
            }
        }
    }

    function testScalarMultiply() public {
        uint i;
        uint j;

        AltBn128.G1Point memory p_1;
        AltBn128.G1Point memory p_2;

        for (i = 1; i < randomG1.length; i++) {
            p_1 = AltBn128.scalarMultiply(AltBn128.G1Point(randomG1[i][0], randomG1[i][1]), i);

            Assert.isTrue(AltBn128.isG1PointOnCurve(p_1), "Multiplied point should be on the curve.");

            p_2 = AltBn128.G1Point(randomG1[i][0], randomG1[i][1]);
            for (j = 1; j < i; j++) {
                p_2 = AltBn128.g1Add(p_2, AltBn128.G1Point(randomG1[i][0], randomG1[i][1]));
            }

            Assert.equal(p_1.x, p_2.x, "Scalar multiplication should match repeat addition.");
            Assert.equal(p_1.y, p_2.y, "Scalar multiplication should match repeat addition.");
        }
    }

    function testBasicPairing() public {
        bool result = AltBn128.pairing(g1, g2, AltBn128.G1Point(g1.x, AltBn128.getP() - g1.y), g2);
        Assert.isTrue(result, "Basic pairing check should succeed.");
    }

    // Verifying sample data generated with bn256.go - Ethereum's bn256/cloudflare curve.
    function testVerifySignature() public {

        // "hello!" message hashed to G1 point using G1HashToPoint from keep-core/pkg/bls/altbn128.go
        AltBn128.G1Point memory message;
        message.x = 5634139805531803244211629196316241342481813136353842610045004964364565232495;
        message.y = 12935759374343796368049060881302766596646163398265176009268480404372697203641;

        // G1 point hashed message above signed with private key = 123 using ScalarMult
        // from go-ethereum/crypto/bn256/cloudflare library
        AltBn128.G1Point memory signature;
        signature.x = 656647519899395589093611455851658769732922739162315270379466002146796568126;
        signature.y = 5296675831567268847773497112983742440203412208935796410329912816023128374551;

        // G2 point representing public key for private key = 123
        AltBn128.G2Point memory publicKey;
        publicKey.x.x = 14066454060412929535985836631817650877381034334390275410072431082437297539867;
        publicKey.x.y = 19276105129625393659655050515259006463014579919681138299520812914148935621072;
        publicKey.y.x = 10109651107942685361120988628892759706059655669161016107907096760613704453218;
        publicKey.y.y = 12642665914920339463975152321804664028480770144655934937445922690262428344269;

        bool result = AltBn128.pairing(signature, g2, AltBn128.G1Point(message.x, AltBn128.getP() - message.y), publicKey);
        Assert.isTrue(result, "Verify signature using precompiled pairing contract should succeed.");
    }

    function testCompressG1Invertibility() public {
        AltBn128.G1Point memory p_1;
        AltBn128.G1Point memory p_2;

        for (uint i = 0; i < randomG1.length; i++) {
            p_1.x = randomG1[i][0];
            p_1.y = randomG1[i][1];
            bytes32 compressed = AltBn128.g1Compress(p_1);
            p_2 = AltBn128.g1Decompress(compressed);
            Assert.equal(p_1.x, p_2.x, "Decompressing a compressed point should give the same x coordinate.");
            Assert.equal(p_1.y, p_2.y, "Decompressing a compressed point should give the same y coordinate.");
        }
    }

    function testCompressG2Invertibility() public {

        AltBn128.G2Point memory p_1;
        AltBn128.G2Point memory p_2;

        for (uint i = 0; i < randomG2.length; i++) {
            p_1.x.x = randomG2[i][0];
            p_1.x.y = randomG2[i][1];
            p_1.y.x = randomG2[i][2];
            p_1.y.y = randomG2[i][3];

            p_2 = AltBn128.g2Decompress(AltBn128.g2Compress(p_1));
            Assert.equal(p_1.x.x, p_2.x.x, "Decompressing a compressed point should give the same x coordinate.");
            Assert.equal(p_1.x.y, p_2.x.y, "Decompressing a compressed point should give the same x coordinate.");
            Assert.equal(p_1.y.x, p_2.y.x, "Decompressing a compressed point should give the same x coordinate.");
            Assert.equal(p_1.y.y, p_2.y.y, "Decompressing a compressed point should give the same x coordinate.");
        }
    }

    function testG2PointOnCurve() public {
        AltBn128.G2Point memory point;

        for (uint i = 0; i < randomG2.length; i++) {
            point.x.x = randomG2[i][0];
            point.x.y = randomG2[i][1];
            point.y.x = randomG2[i][2];
            point.y.y = randomG2[i][3];

            Assert.isTrue(AltBn128.isG2PointOnCurve(point), "Valid points should be on the curve.");
        }

        for (uint i = 0; i < randomG2.length; i++) {
            point.x.x = randomG2[i][2];
            point.x.y = randomG2[i][3];
            point.y.x = randomG2[i][0];
            point.y.y = randomG2[i][1];

            Assert.isFalse(AltBn128.isG2PointOnCurve(point), "Invalid points should not be on the curve.");
        }
    }
}
