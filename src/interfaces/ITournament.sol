pragma solidity ^0.8.0;

import "./IPoolMember.sol";

interface ITournament {
	// define events
	event SquadTeamUpdated(address indexed player, uint256[] nftIds);
	event OpponentChanged(address indexed player, address indexed newOpponent);
	event PoolRewardSet(address indexed poolReward);
	event BattleResult(
		address indexed attacker,
		address indexed defender,
		bool battleResult,
		uint256 attackerTScore,
		uint256 attackerRScore,
		uint256 defenderTScore,
		uint256 defenderDScore
	);
	event Claimed(address indexed player, uint256 amount);
    event RoundFinalized(uint256 round, uint256 reward);

	// define errors
	error InvalidSquadTeamSize(uint256 _size);
	error MustMaintain1NFTWhenTournamentRunning();
	error MustBeOwnerOfNFT(uint256 _nftId);
	error NotEnoughPlayers();
	error NoOpponent();
	error AlreadyClaimed(address player);
	error RoundNotFinished(uint256 round);
	error TournamentNotFinished();
	error TournamentHasEnded();
	error RewardHasBeenFinalized(uint256 round);
	error NotEnoughBalance();
	error BattleTooQuick();

	struct PlayerInfo {
		uint256[] squad;
		address opponent;
		uint256 reward;
		uint256 claimed;
		uint256 lastBattleAt;
	}

	struct PlayerRankInfo {
		uint256 score;
		uint256 battleCount;
		address player;
		uint256[] squad;
	}

	struct RoundInfo {
		uint256 startTime;
		uint256 endTime;
		uint256 totalPlayers;
		uint256 rewards;
	}

	struct TournamentInfo {
		uint256 poolReward;
		uint256 totalRound;
		uint256 currentRound;
		uint256 tournamentReward;
		uint256 startTime;
		uint256 endTime;
		uint256 roundDuration;
		uint256 totalPlayers;
	}

	struct BattleHistory {
		address attacker;
		address defender;
		bool result;
		uint256 attackerScoreChange;
		uint256 defenderScoreChange;
		uint256 playedAt;
		uint256[] attackerSquad;
		uint256[] defenderSquad;
	}

	function pickSquad(uint256[] memory _squad) external;

	function opponent(address player_) external view returns (address opponent, uint256[] memory squad);

	function rerollOpponent() external;

	function battle() external;

	function currentRound() external view returns (uint256);

	function roundInfo(uint256 roundIndex_) external view returns (RoundInfo memory roundInfo);

	function tournamentInfo() external view returns (TournamentInfo memory tournamentInfo);

	function roundRanks(uint256 rankIndex_, uint256 offset_, uint256 limit_) external view returns (PlayerRankInfo[] memory);

	function playerInfo(address player_, uint256 rankIndex_) external view returns (PlayerRankInfo memory);

	function claimable(address player_) external view returns (uint256);

	function claimReward() external;

	function battleHistoryCounter(address player_) external view returns (uint256);

	function battleHistories(address player_, uint256 offset_, uint256 limit_) external view returns (BattleHistory[] memory);
}
