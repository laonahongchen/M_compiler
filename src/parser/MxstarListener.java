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
	 * Enter a parse tree produced by the {@code intType}
	 * labeled alternative in {@link MxstarParser#variableTypeBasic}.
	 * @param ctx the parse tree
	 */
	void enterIntType(MxstarParser.IntTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code intType}
	 * labeled alternative in {@link MxstarParser#variableTypeBasic}.
	 * @param ctx the parse tree
	 */
	void exitIntType(MxstarParser.IntTypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code stringType}
	 * labeled alternative in {@link MxstarParser#variableTypeBasic}.
	 * @param ctx the parse tree
	 */
	void enterStringType(MxstarParser.StringTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code stringType}
	 * labeled alternative in {@link MxstarParser#variableTypeBasic}.
	 * @param ctx the parse tree
	 */
	void exitStringType(MxstarParser.StringTypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code boolType}
	 * labeled alternative in {@link MxstarParser#variableTypeBasic}.
	 * @param ctx the parse tree
	 */
	void enterBoolType(MxstarParser.BoolTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code boolType}
	 * labeled alternative in {@link MxstarParser#variableTypeBasic}.
	 * @param ctx the parse tree
	 */
	void exitBoolType(MxstarParser.BoolTypeContext ctx);
	/**
	 * Enter a parse tree produced by the {@code identifierType}
	 * labeled alternative in {@link MxstarParser#variableTypeBasic}.
	 * @param ctx the parse tree
	 */
	void enterIdentifierType(MxstarParser.IdentifierTypeContext ctx);
	/**
	 * Exit a parse tree produced by the {@code identifierType}
	 * labeled alternative in {@link MxstarParser#variableTypeBasic}.
	 * @param ctx the parse tree
	 */
	void exitIdentifierType(MxstarParser.IdentifierTypeContext ctx);
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
	 * Enter a parse tree produced by {@link MxstarParser#blockBody}.
	 * @param ctx the parse tree
	 */
	void enterBlockBody(MxstarParser.BlockBodyContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#blockBody}.
	 * @param ctx the parse tree
	 */
	void exitBlockBody(MxstarParser.BlockBodyContext ctx);
	/**
	 * Enter a parse tree produced by {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 */
	void enterStatement(MxstarParser.StatementContext ctx);
	/**
	 * Exit a parse tree produced by {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 */
	void exitStatement(MxstarParser.StatementContext ctx);
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
	 * Enter a parse tree produced by the {@code continueStmt}
	 * labeled alternative in {@link MxstarParser#jumpStatement}.
	 * @param ctx the parse tree
	 */
	void enterContinueStmt(MxstarParser.ContinueStmtContext ctx);
	/**
	 * Exit a parse tree produced by the {@code continueStmt}
	 * labeled alternative in {@link MxstarParser#jumpStatement}.
	 * @param ctx the parse tree
	 */
	void exitContinueStmt(MxstarParser.ContinueStmtContext ctx);
	/**
	 * Enter a parse tree produced by the {@code breakStmt}
	 * labeled alternative in {@link MxstarParser#jumpStatement}.
	 * @param ctx the parse tree
	 */
	void enterBreakStmt(MxstarParser.BreakStmtContext ctx);
	/**
	 * Exit a parse tree produced by the {@code breakStmt}
	 * labeled alternative in {@link MxstarParser#jumpStatement}.
	 * @param ctx the parse tree
	 */
	void exitBreakStmt(MxstarParser.BreakStmtContext ctx);
	/**
	 * Enter a parse tree produced by the {@code returnStmt}
	 * labeled alternative in {@link MxstarParser#jumpStatement}.
	 * @param ctx the parse tree
	 */
	void enterReturnStmt(MxstarParser.ReturnStmtContext ctx);
	/**
	 * Exit a parse tree produced by the {@code returnStmt}
	 * labeled alternative in {@link MxstarParser#jumpStatement}.
	 * @param ctx the parse tree
	 */
	void exitReturnStmt(MxstarParser.ReturnStmtContext ctx);
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
	 * Enter a parse tree produced by the {@code ForEXpr}
	 * labeled alternative in {@link MxstarParser#loopStatement}.
	 * @param ctx the parse tree
	 */
	void enterForEXpr(MxstarParser.ForEXprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ForEXpr}
	 * labeled alternative in {@link MxstarParser#loopStatement}.
	 * @param ctx the parse tree
	 */
	void exitForEXpr(MxstarParser.ForEXprContext ctx);
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