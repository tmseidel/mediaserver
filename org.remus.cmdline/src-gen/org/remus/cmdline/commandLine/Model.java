/**
 */
package org.remus.cmdline.commandLine;

import org.eclipse.emf.common.util.EList;

import org.eclipse.emf.ecore.EObject;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Model</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link org.remus.cmdline.commandLine.Model#getImports <em>Imports</em>}</li>
 *   <li>{@link org.remus.cmdline.commandLine.Model#getPrograms <em>Programs</em>}</li>
 * </ul>
 * </p>
 *
 * @see org.remus.cmdline.commandLine.CommandLinePackage#getModel()
 * @model
 * @generated
 */
public interface Model extends EObject
{
  /**
   * Returns the value of the '<em><b>Imports</b></em>' containment reference list.
   * The list contents are of type {@link org.remus.cmdline.commandLine.Import}.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Imports</em>' containment reference list isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Imports</em>' containment reference list.
   * @see org.remus.cmdline.commandLine.CommandLinePackage#getModel_Imports()
   * @model containment="true"
   * @generated
   */
  EList<Import> getImports();

  /**
   * Returns the value of the '<em><b>Programs</b></em>' containment reference.
   * <!-- begin-user-doc -->
   * <p>
   * If the meaning of the '<em>Programs</em>' containment reference isn't clear,
   * there really should be more of a description here...
   * </p>
   * <!-- end-user-doc -->
   * @return the value of the '<em>Programs</em>' containment reference.
   * @see #setPrograms(Program)
   * @see org.remus.cmdline.commandLine.CommandLinePackage#getModel_Programs()
   * @model containment="true"
   * @generated
   */
  Program getPrograms();

  /**
   * Sets the value of the '{@link org.remus.cmdline.commandLine.Model#getPrograms <em>Programs</em>}' containment reference.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @param value the new value of the '<em>Programs</em>' containment reference.
   * @see #getPrograms()
   * @generated
   */
  void setPrograms(Program value);

} // Model