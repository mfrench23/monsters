import React from "react"
import PropTypes from "prop-types"
class ManyToManyCheckbox extends React.Component {
  constructor(props) {
    super(props);
    this.state = {checked: !!props.checked, val: props.val};
  }

  render () {
    var opts = {};
    opts['id'] = this.props.identifier;
    opts['name'] = this.props.identifier;
    opts['key'] = this.props.identifier;
    opts['value'] = this.state.val;
    if( this.state.checked ) {
      opts['defaultChecked'] = true;
    }
    return (
      <input {...opts} type="checkbox" ref={(input) => this.input = input} />
    );
  }
}

ManyToManyCheckbox.propTypes = {
  identifier: PropTypes.string,
  val: PropTypes.string
};
export default ManyToManyCheckbox
