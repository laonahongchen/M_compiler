// Generated from D:/homework/2018-19-second/compiler/mxstar/src/parser\Mxstar.g4 by ANTLR 4.7.2
package parser;
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link MxstarParser}.
 */
public interface MxstarListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link MxstarParser#program}.
	 * @param ctx the parse tree
	 */
	void enterProgram(MxstarParser.ProgramContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#program}.
	 * @param ctx the parse tree
	 */
	void exitProgram(MxstarParser.ProgramContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#declarations}.
	 * @param ctx the parse tree
	 */
	void enterDeclarations(MxstarParser.DeclarationsContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#declarations}.
	 * @param ctx the parse tree
	 */
	void exitDeclarations(MxstarParser.DeclarationsContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#functionDefinition}.
	 * @param ctx the parse tree
	 */
	void enterFunctionDefinition(MxstarParser.FunctionDefinitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#functionDefinition}.
	 * @param ctx the parse tree
	 */
	void exitFunctionDefinition(MxstarParser.FunctionDefinitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#classDefinition}.
	 * @param ctx the parse tree
	 */
	void enterClassDefinition(MxstarParser.ClassDefinitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#classDefinition}.
	 * @param ctx the parse tree
	 */
	void exitClassDefinition(MxstarParser.ClassDefinitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#variableDeclaration}.
	 * @param ctx the parse tree
	 */
	void enterVariableDeclaration(MxstarParser.VariableDeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#variableDeclaration}.
	 * @param ctx the parse tree
	 */
	void exitVariableDeclaration(MxstarParser.VariableDeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#variableList}.
	 * @param ctx the parse tree
	 */
	void enterVariableList(MxstarParser.VariableListContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#variableList}.
	 * @param ctx the parse tree
	 */
	void exitVariableList(MxstarParser.VariableListContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#variableDefinition}.
	 * @param ctx the parse tree
	 */
	void enterVariableDefinition(MxstarParser.VariableDefinitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#variableDefinition}.
	 * @param ctx the parse tree
	 */
	void exitVariableDefinition(MxstarParser.VariableDefinitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#memberDeclaration}.
	 * @param ctx the parse tree
	 */
	void enterMemberDeclaration(MxstarParser.MemberDeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#memberDeclaration}.
	 * @param ctx the parse tree
	 */
	void exitMemberDeclaration(MxstarParser.MemberDeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#constructDefinition}.
	 * @param ctx the parse tree
	 */
	void enterConstructDefinition(MxstarParser.ConstructDefinitionContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#constructDefinition}.
	 * @param ctx the parse tree
	 */
	void exitConstructDefinition(MxstarParser.ConstructDefinitionContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#variableTypeOrVoid}.
	 * @param ctx the parse tree
	 */
	void enterVariableTypeOrVoid(MxstarParser.VariableTypeOrVoidContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#variableTypeOrVoid}.
	 * @param ctx the parse tree
	 */
	void exitVariableTypeOrVoid(MxstarParser.VariableTypeOrVoidContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#parameterDeclarationList}.
	 * @param ctx the parse tree
	 */
	void enterParameterDeclarationList(MxstarParser.ParameterDeclarationListContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#parameterDeclarationList}.
	 * @param ctx the parse tree
	 */
	void exitParameterDeclarationList(MxstarParser.ParameterDeclarationListContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#parameterDeclaration}.
	 * @param ctx the parse tree
	 */
	void enterParameterDeclaration(MxstarParser.ParameterDeclarationContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#parameterDeclaration}.
	 * @param ctx the parse tree
	 */
	void exitParameterDeclaration(MxstarParser.ParameterDeclarationContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#variableType}.
	 * @param ctx the parse tree
	 */
	void enterVariableType(MxstarParser.VariableTypeContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#variableType}.
	 * @param ctx the parse tree
	 */
	void exitVariableType(MxstarParser.VariableTypeContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#empty}.
	 * @param ctx the parse tree
	 */
	void enterEmpty(MxstarParser.EmptyContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#empty}.
	 * @param ctx the parse tree
	 */
	void exitEmpty(MxstarParser.EmptyContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#variableTypeBasic}.
	 * @param ctx the parse tree
	 */
	void enterVariableTypeBasic(MxstarParser.VariableTypeBasicContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#variableTypeBasic}.
	 * @param ctx the parse tree
	 */
	void exitVariableTypeBasic(MxstarParser.VariableTypeBasicContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#block}.
	 * @param ctx the parse tree
	 */
	void enterBlock(MxstarParser.BlockContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#block}.
	 * @param ctx the parse tree
	 */
	void exitBlock(MxstarParser.BlockContext ctx);
	/**
	 * Enter a parse tree produced by the {@code blockStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 */
	void enterBlockStmt(MxstarParser.BlockStmtContext ctx);
	/**
	 * Exit a parse tree produced by the {@code blockStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 */
	void exitBlockStmt(MxstarParser.BlockStmtContext ctx);
	/**
	 * Enter a parse tree produced by the {@code exprStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 */
	void enterExprStmt(MxstarParser.ExprStmtContext ctx);
	/**
	 * Exit a parse tree produced by the {@code exprStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 */
	void exitExprStmt(MxstarParser.ExprStmtContext ctx);
	/**
	 * Enter a parse tree produced by the {@code conditionStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 */
	void enterConditionStmt(MxstarParser.ConditionStmtContext ctx);
	/**
	 * Exit a parse tree produced by the {@code conditionStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 */
	void exitConditionStmt(MxstarParser.ConditionStmtContext ctx);
	/**
	 * Enter a parse tree produced by the {@code loopStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 */
	void enterLoopStmt(MxstarParser.LoopStmtContext ctx);
	/**
	 * Exit a parse tree produced by the {@code loopStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 */
	void exitLoopStmt(MxstarParser.LoopStmtContext ctx);
	/**
	 * Enter a parse tree produced by the {@code jumpStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 */
	void enterJumpStmt(MxstarParser.JumpStmtContext ctx);
	/**
	 * Exit a parse tree produced by the {@code jumpStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 */
	void exitJumpStmt(MxstarParser.JumpStmtContext ctx);
	/**
	 * Enter a parse tree produced by the {@code variableStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 */
	void enterVariableStmt(MxstarParser.VariableStmtContext ctx);
	/**
	 * Exit a parse tree produced by the {@code variableStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 */
	void exitVariableStmt(MxstarParser.VariableStmtContext ctx);
	/**
	 * Enter a parse tree produced by the {@code emptyStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 */
	void enterEmptyStmt(MxstarParser.EmptyStmtContext ctx);
	/**
	 * Exit a parse tree produced by the {@code emptyStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 */
	void exitEmptyStmt(MxstarParser.EmptyStmtContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#conditionStatement}.
	 * @param ctx the parse tree
	 */
	void enterConditionStatement(MxstarParser.ConditionStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#conditionStatement}.
	 * @param ctx the parse tree
	 */
	void exitConditionStatement(MxstarParser.ConditionStatementContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#jumpStatement}.
	 * @param ctx the parse tree
	 */
	void enterJumpStatement(MxstarParser.JumpStatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#jumpStatement}.
	 * @param ctx the parse tree
	 */
	void exitJumpStatement(MxstarParser.JumpStatementContext ctx);
	/**
	 * Enter a parse tree produced by the {@code WhileExpr}
	 * labeled alternative in {@link MxstarParser#loopStatement}.
	 * @param ctx the parse tree
	 */
	void enterWhileExpr(MxstarParser.WhileExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code WhileExpr}
	 * labeled alternative in {@link MxstarParser#loopStatement}.
	 * @param ctx the parse tree
	 */
	void exitWhileExpr(MxstarParser.WhileExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ForExpr}
	 * labeled alternative in {@link MxstarParser#loopStatement}.
	 * @param ctx the parse tree
	 */
	void enterForExpr(MxstarParser.ForExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ForExpr}
	 * labeled alternative in {@link MxstarParser#loopStatement}.
	 * @param ctx the parse tree
	 */
	void exitForExpr(MxstarParser.ForExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code newExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterNewExpr(MxstarParser.NewExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code newExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitNewExpr(MxstarParser.NewExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code unaryExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterUnaryExpr(MxstarParser.UnaryExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code unaryExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitUnaryExpr(MxstarParser.UnaryExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code primaryExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterPrimaryExpr(MxstarParser.PrimaryExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code primaryExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitPrimaryExpr(MxstarParser.PrimaryExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code arrayExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterArrayExpr(MxstarParser.ArrayExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code arrayExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitArrayExpr(MxstarParser.ArrayExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code memberExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterMemberExpr(MxstarParser.MemberExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code memberExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitMemberExpr(MxstarParser.MemberExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code binaryExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterBinaryExpr(MxstarParser.BinaryExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code binaryExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitBinaryExpr(MxstarParser.BinaryExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code subExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterSubExpr(MxstarParser.SubExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code subExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitSubExpr(MxstarParser.SubExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code assignExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterAssignExpr(MxstarParser.AssignExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code assignExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitAssignExpr(MxstarParser.AssignExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code funtionExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void enterFuntionExpr(MxstarParser.FuntionExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code funtionExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 */
	void exitFuntionExpr(MxstarParser.FuntionExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#functionCall}.
	 * @param ctx the parse tree
	 */
	void enterFunctionCall(MxstarParser.FunctionCallContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#functionCall}.
	 * @param ctx the parse tree
	 */
	void exitFunctionCall(MxstarParser.FunctionCallContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#creator}.
	 * @param ctx the parse tree
	 */
	void enterCreator(MxstarParser.CreatorContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#creator}.
	 * @param ctx the parse tree
	 */
	void exitCreator(MxstarParser.CreatorContext ctx);
}