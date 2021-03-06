pragma solidity 0.5.16;

import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
import "./ExtendedMath.sol";

library Sigmoid {
    using SafeMath for uint256;
    using ExtendedMath for uint256;

    struct State {
        uint256 a;
        int256 b;
        uint256 c;
    }

    /**
     * @dev Sets sigmoid parameters
     * @param _a Sigmoid parameter A.
     * @param _b Sigmoid parameter B.
     * @param _c Sigmoid parameter C.
     */
    function setParameters(State storage self, uint256 _a, int256 _b, uint256 _c) internal {
        require(_c != 0); // prevent division by zero
        self.a = _a;
        self.b = _b;
        self.c = _c;
    }

    /**
     * @return Sigmoid parameters
     */
    function getParameters(State storage self) internal view returns (uint256, int256, uint256) {
        return (self.a, self.b, self.c);
    }

    /**
     * @return The corresponding Y value for a given X value
     */
    function calculate(State storage self, int256 _x) internal view returns (uint256) {
        int256 k = _x - self.b;
        if (k < 0) return 0;
        uint256 uk = uint256(k);
        return self.a.mul(uk).div(uk.pow2().add(self.c).sqrt());
    }
}
