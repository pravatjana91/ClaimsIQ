# run_evaluation.py
import sys, argparse
 
def run_evaluation(prompt_file, min_faithfulness):
    prompt = open(prompt_file).read()
    # Reuses Day 13's faithfulness_evaluator against a fixed eval dataset
    results = evaluate_against_dataset(prompt, dataset="claimsiq-eval-set")
    print(f"Faithfulness: {results['faithfulness']:.2f}")
    if results["faithfulness"] < min_faithfulness:
        print("FAILED: faithfulness below threshold")
        sys.exit(1)
    print("PASSED")
 
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--prompt-file", default="prompts/validator_v2.txt")
    parser.add_argument("--min-faithfulness", type=float, default=0.8)
    args = parser.parse_args()
    run_evaluation(args.prompt_file, args.min_faithfulness)