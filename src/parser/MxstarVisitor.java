// Generated from D:/homework/2018-19-second/compiler/mxstar/src/parser\Mxstar.g4 by ANTLR 4.7.2
package parser;
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link MxstarParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface MxstarVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link MxstarParser#program}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProgram(MxstarParser.ProgramContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#declarations}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDeclarations(MxstarParser.DeclarationsContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#functionDefinition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunctionDefinition(MxstarParser.FunctionDefinitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#classDefinition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitClassDefinition(MxstarParser.ClassDefinitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#variableDeclaration}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVariableDeclaration(MxstarParser.VariableDeclarationContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#variableList}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVariableList(MxstarParser.VariableListContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#variableDefinition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVariableDefinition(MxstarParser.VariableDefinitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#memberDeclaration}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMemberDeclaration(MxstarParser.MemberDeclarationContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#constructDefinition}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitConstructDefinition(MxstarParser.ConstructDefinitionContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#variableTypeOrVoid}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVariableTypeOrVoid(MxstarParser.VariableTypeOrVoidContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#parameterDeclarationList}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParameterDeclarationList(MxstarParser.ParameterDeclarationListContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#parameterDeclaration}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParameterDeclaration(MxstarParser.ParameterDeclarationContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#variableType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVariableType(MxstarParser.VariableTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#empty}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEmpty(MxstarParser.EmptyContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#variableTypeBasic}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVariableTypeBasic(MxstarParser.VariableTypeBasicContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#block}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBlock(MxstarParser.BlockContext ctx);
	/**
	 * Visit a parse tree produced by the {@code blockStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBlockStmt(MxstarParser.BlockStmtContext ctx);
	/**
	 * Visit a parse tree produced by the {@code exprStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExprStmt(MxstarParser.ExprStmtContext ctx);
	/**
	 * Visit a parse tree produced by the {@code conditionStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitConditionStmt(MxstarParser.ConditionStmtContext ctx);
	/**
	 * Visit a parse tree produced by the {@code loopStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLoopStmt(MxstarParser.LoopStmtContext ctx);
	/**
	 * Visit a parse tree produced by the {@code jumpStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJumpStmt(MxstarParser.JumpStmtContext ctx);
	/**
	 * Visit a parse tree produced by the {@code variableStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVariableStmt(MxstarParser.VariableStmtContext ctx);
	/**
	 * Visit a parse tree produced by the {@code emptyStmt}
	 * labeled alternative in {@link MxstarParser#statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitEmptyStmt(MxstarParser.EmptyStmtContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#conditionStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitConditionStatement(MxstarParser.ConditionStatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#jumpStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitJumpStatement(MxstarParser.JumpStatementContext ctx);
	/**
	 * Visit a parse tree produced by the {@code WhileExpr}
	 * labeled alternative in {@link MxstarParser#loopStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitWhileExpr(MxstarParser.WhileExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code ForExpr}
	 * labeled alternative in {@link MxstarParser#loopStatement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitForExpr(MxstarParser.ForExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code newExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNewExpr(MxstarParser.NewExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code unaryExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUnaryExpr(MxstarParser.UnaryExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code primaryExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPrimaryExpr(MxstarParser.PrimaryExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code arrayExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitArrayExpr(MxstarParser.ArrayExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code memberExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMemberExpr(MxstarParser.MemberExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code binaryExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBinaryExpr(MxstarParser.BinaryExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code subExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSubExpr(MxstarParser.SubExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code assignExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAssignExpr(MxstarParser.AssignExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code funtionExpr}
	 * labeled alternative in {@link MxstarParser#expression}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFuntionExpr(MxstarParser.FuntionExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#functionCall}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunctionCall(MxstarParser.FunctionCallContext ctx);
	/**
	 * Visit a parse tree produced by {@link MxstarParser#creator}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCreator(MxstarParser.CreatorContext ctx);
}